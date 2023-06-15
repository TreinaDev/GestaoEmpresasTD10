class Position < ApplicationRecord
  belongs_to :department
  has_one :company, through: :department
  validates :name, :description, :card_type_id, presence: true
  validates :code, uniqueness: true
end
