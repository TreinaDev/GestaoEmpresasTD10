class Employee < ApplicationRecord
  belongs_to :departament
  belongs_to :user
  belongs_to :position
end
