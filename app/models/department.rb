class Department < ApplicationRecord
  belongs_to :company
  validates :name, :description, :code, presence: true
end
