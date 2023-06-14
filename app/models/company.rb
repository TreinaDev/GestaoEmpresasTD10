class Company < ApplicationRecord
  has_one_attached :logo
  has_many :departments
  has_many :positions, through: :departments
  validates :registration_number, uniqueness: true
  validates :brand_name, :corporate_name, :registration_number,
            :address, :phone_number, :email, :domain, :logo, presence: true
end
