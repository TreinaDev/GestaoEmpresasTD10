class Position < ApplicationRecord
  has_many :employee_profiles, dependent: :nullify
  belongs_to :department
  has_one :company, through: :department
  validates :name, :description, :card_type_id, :code, presence: true
  validates :code, uniqueness: true, format: { with: /\A[A-Z]{3}\d{3}\z/, message: :invalid_format }
end
