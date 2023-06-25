class EmployeeProfile < ApplicationRecord
  belongs_to :department
  belongs_to :user, optional: true
  belongs_to :position

  validates :name, :cpf, :rg, :address, :email, :phone_number, :status, :birth_date, :admission_date,
            :marital_status, presence: true

  validates :cpf, uniqueness: true

  enum status: { unblocked: 0, blocked: 5, fired: 10 }, _default: :unblocked
  enum marital_status: { single: 1, married: 4, widower: 8, divorced: 10 }
end
