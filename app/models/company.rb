class Company < ApplicationRecord
  has_many :department, dependent: :nullify
  has_one_attached :logo
  validates :registration_number, uniqueness: true
  validates :brand_name, :corporate_name, :registration_number,
            :address, :phone_number, :email, :domain, :logo, presence: true
end
