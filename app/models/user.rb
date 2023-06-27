class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :assign_role
  before_validation :clean_cpf
  after_create :update_employee, if: -> { employee? }

  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validation
  validates :role, presence: true

  enum role: { admin: 0, manager: 1, employee: 2 }, _default: :employee

  has_one :employee_profile, dependent: nil
  has_one :department, through: :employee_profile
  has_many :recharge_histories, dependent: :nullify, foreign_key: 'created_by', inverse_of: :creator

  def description
    if employee_profile.nil?
      "#{User.human_attribute_name(:roles, count: 'other').fetch(role.to_sym).upcase} - #{email}"
    else
      description_employee
    end
  end

  def description_employee
    "#{User.human_attribute_name(:roles, count: 'other')
    .fetch(role.to_sym).upcase} - #{employee_profile.social_name.presence || employee_profile.name}"
  end

  def block!
    return unless employee_profile

    employee_profile.update(status: :blocked)
  end

  def unblock!
    return unless employee_profile

    employee_profile.update(status: :unblocked)
  end

  def blocked?
    employee_profile && employee_profile.status == 'blocked'
  end

  def active_for_authentication?
    super && !blocked?
  end

  def inactive_message
    blocked? ? :blocked : super
  end

  def clean_cpf
    cpf&.gsub!(/\D/, '')
  end

  private

  def assign_role
    if email.include?('@punti.com')
      self.role = :admin
    elsif ManagerEmails.find_by(email:)
      self.role = :manager
    elsif EmployeeProfile.find_by(cpf:)
      self.role = :employee
    else
      errors.add(:base, 'Email ou CPF não estão cadastrados nas tabelas correspondentes')
      throw(:abort)
    end
  end

  def update_employee
    employee = EmployeeProfile.find_by(cpf:)
    employee.update(user_id: id)
  end

  def cpf_validation
    errors.add(:cpf, 'INVÁLIDO!') unless cpf_valid_p1(cpf) && cpf_valid_p2(cpf)
  end

  def cpf_valid_p1(cpf)
    return false if cpf.nil? || cpf.length != 11

    sum1 = 0
    9.times do |i|
      sum1 += cpf[i].to_i * (10 - i)
    end

    remainder1 = sum1 % 11
    first_digit = remainder1 < 2 ? 0 : 11 - remainder1
    return false if first_digit != cpf[9].to_i

    true
  end

  def cpf_valid_p2(cpf)
    sum2 = 0
    10.times do |i|
      sum2 += cpf[i].to_i * (11 - i)
    end

    remainder2 = sum2 % 11
    second_digit = remainder2 < 2 ? 0 : 11 - remainder2
    return false if second_digit != cpf[10].to_i

    true
  end
end
