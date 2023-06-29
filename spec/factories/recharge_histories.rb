FactoryBot.define do
  factory :recharge_history do
    value { 1 }
    recharge_date { Time.zone.today }
    employee_profile { nil }
  end
end
