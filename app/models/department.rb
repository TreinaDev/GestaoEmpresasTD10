class Department < ApplicationRecord
  belongs_to :company
  has_many :positions, dependent: :destroy
end
