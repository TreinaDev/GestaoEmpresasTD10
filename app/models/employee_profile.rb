class EmployeeProfile < ApplicationRecord
  belongs_to :department
  belongs_to :user, optional: true
  belongs_to :position

  validates :name, :social_name, :cpf, :email, :phone_number, :status, :birth_date, presence: true

  validates :admission_date, presence: true, unless: :manager?
  validates :marital_status, presence: true, unless: :manager?
  validates :address, presence: true, unless: :manager?
  validates :rg, presence: true, unless: :manager?

  validates :cpf, uniqueness: true

  enum status: { unblocked: 0, blocked: 5, fired: 10 }, _default: :unblocked
  enum marital_status: { single: 1, married: 4, widower: 8, divorced: 10 }


  private

  def manager? 
    user&.manager?
  end
end
