class Position < ApplicationRecord
  has_many :employee_profiles, dependent: :nullify
  belongs_to :department
end
