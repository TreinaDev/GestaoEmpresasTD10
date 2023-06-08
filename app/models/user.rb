class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :cpf

  enum role: { admin: 1, manager: 3, employee: 5 }

  before_validation :assign_role
  after_create :update_employee, if: -> { self.employee? }

  validates :role, presence: true

  def assign_role
    if email.include?('@punti.com')
      self.role = :admin
    elsif Manager.find_by(email: self.email)
      self.role = :manager
    elsif Employee.find_by(cpf: self.cpf)
      self.role = :employee
    else
      errors.add(:base, 'Email ou CPF não estão cadastrados nas tabelas correspondentes')
      throw(:abort)
    end
  end

  def update_employee
    employee = Employee.find_by(cpf: self.cpf)
    employee.update(user_id: self.id)
  end
end
