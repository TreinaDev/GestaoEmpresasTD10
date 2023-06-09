class Employee < ApplicationRecord
  belongs_to :department
  belongs_to :user
  belongs_to :position

  enum status: {unblocked: 0, blocked: 5, fired: 10}, _default: :unblocked
end
