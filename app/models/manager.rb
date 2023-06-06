class Manager < ApplicationRecord
  belongs_to :create_by, class_name: 'User', foreign_key: 'create_by_id'
end
