FactoryBot.define do
  factory :employee_profile do
    name { 'Roberto Carlos Nascimento' }
    social_name { 'Roberto Carlos' }
    cpf { '69142235219' }
    rg { '12345678901' }
    address { 'Rua do funcionário, 1200' }
    email { 'funcionario@empresa.com' }
    phone_number { '1199776655' }
    status { nil }
    birth_date { '2023-06-06' }
    admission_date { '2023-06-06' }
    dismissal_date { '2023-06-06' }
    marital_status { 1 }
    department { nil }
    user { nil }
    position { nil }
  end
end
