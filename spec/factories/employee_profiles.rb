FactoryBot.define do
  factory :employee_profile do
    name { 'Roberto Carlos Nascimento' }
    social_name { 'Roberto Carlos' }
    cpf { nil }
    rg { '12345678901' }
    address { 'Rua do funcionário, 1200' }
    email { nil}
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
      email { 'employee@apple.com' }
      cpf { '29963810926' }
    end

    trait :manager do
      after(:build) do |employee_profile|
        employee_profile.user = create(:manager_user)
        employee_profile.cpf = employee_profile.user.cpf
        employee_profile.email = employee_profile.user.email
      end
    end
  end
end
