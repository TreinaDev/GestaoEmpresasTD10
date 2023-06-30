FactoryBot.define do
  factory :employee_profile do
    name { 'Roberto Carlos Nascimento' }
    social_name { 'Roberto Carlos' }
    cpf { nil }
    sequence(:rg) { |n| "1234567890#{n.to_s.rjust(2, '0')}" }
    address { 'Rua do funcionário, 1200' }
    email { nil }
    phone_number { '11997766555' }
    status { 'unblocked' }
    birth_date { 19.years.ago }
    admission_date { 1.year.ago }
    dismissal_date { 1.day.from_now }
    marital_status { 1 }
    department
    user { nil }
    position

    trait :employee do
      email { 'employee@microsoft.com' }
      cpf { '29963810926' }
    end

    trait :manager do
      email { 'manager@microsoft.com' }
      cpf { '15703243017' }
    end
  end
end
