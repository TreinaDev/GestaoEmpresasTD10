class Department < ApplicationRecord
  belongs_to :company
  has_many :positions
end
