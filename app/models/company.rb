class Company < ApplicationRecord
  has_one_attached :logo
  validates :brand_name, :corporate_name, :registration_number, :address, :phone_number, :email, :domain, :logo,
            presence: true
end
