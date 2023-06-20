class Company < ApplicationRecord
  has_many :department, dependent: :nullify
  has_one_attached :logo
  has_many :departments, dependent: :destroy
  has_many :positions, through: :departments
  has_many :managers, dependent: :destroy
  validates :registration_number, uniqueness: true
  validates :brand_name, :corporate_name, :registration_number,
            :address, :phone_number, :email, :domain, :logo, presence: true
end
