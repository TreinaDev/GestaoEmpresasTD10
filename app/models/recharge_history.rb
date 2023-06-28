class RechargeHistory < ApplicationRecord
  belongs_to :employee_profile
  validates :value, :recharge_date, presence: true
end
