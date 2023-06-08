class Employee < ApplicationRecord
  belongs_to :department
  belongs_to :user, optional: true
  belongs_to :position
end
