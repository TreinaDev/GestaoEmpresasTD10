class RechargeHistory < ApplicationRecord
  belongs_to :employee_profile, inverse_of: :recharge_histories
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by', inverse_of: :recharge_histories
end
