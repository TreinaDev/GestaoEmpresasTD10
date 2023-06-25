FactoryBot.define do
  factory :employee_profile do
    name { 'Roberto Carlos Nascimento' }
    social_name { 'Roberto Carlos' }
    cpf { nil }
    rg { '12345678901' }
    address { 'Rua do funcionário, 1200' }
    email { nil }
    phone_number { '1199776655' }
    status { 'unblocked' }
    birth_date { '2023-06-06' }
    admission_date { '2023-06-06' }
    dismissal_date { '2023-06-06' }
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
