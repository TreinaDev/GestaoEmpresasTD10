class Department < ApplicationRecord
  has_many :employee_profiles, dependent: :nullify
  belongs_to :company
end
