class User < ApplicationRecord
  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validation
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { admin: 0, manager: 1, employee: 2 }, _default: :employee
  before_save :set_admin_role
  before_save :set_manager_role

  def description
    "#{User.human_attribute_name(:roles, count: 'other').fetch(role.to_sym).upcase}: #{email}"
  end

  private

  def set_admin_role
    self.role = 'admin' if email.match?('@punti.com')
  end

  def set_manager_role
    return unless Manager.exists?(email:)

    self.role = 'manager'
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
