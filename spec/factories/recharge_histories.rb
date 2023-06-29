FactoryBot.define do
  factory :recharge_history do
    value { 1.5 }
    recharge_date { '2023-06-27' }
    employee_profile { nil }
  end
end
