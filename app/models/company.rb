class Company < ApplicationRecord
  has_one_attached :logo
  has_many :departments, dependent: :destroy
  has_many :positions, through: :departments
  has_many :managers, dependent: :destroy
  validates :registration_number, uniqueness: true
  validates :brand_name, :corporate_name, :registration_number,
            :address, :phone_number, :email, :domain, :logo, presence: true
  before_validation :clean_registration_number

  def block_employee
    departments.each do |d|
      d.employee_profiles.each do |e|
        e.update(status: 'blocked')
        GetCardApi.deactivate(GetCardApi.show(e.cpf).id) if e.card_status
      end
    end
  end

  def active_employee
    departments.each do |d|
      d.employee_profiles.each do |e|
        e.update(status: 'unblocked')
        GetCardApi.activate(GetCardApi.show(e.cpf).id) if e.card_status
      end
    end
  end

  private

  def clean_registration_number
    registration_number&.gsub!(/\D/, '')
  end
end
