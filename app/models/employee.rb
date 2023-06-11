class Employee < ApplicationRecord
  belongs_to :department
  belongs_to :user
  belongs_to :position
end
