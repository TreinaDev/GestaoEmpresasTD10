class Position < ApplicationRecord
  belongs_to :department
  has_one :company, through: :department
end
