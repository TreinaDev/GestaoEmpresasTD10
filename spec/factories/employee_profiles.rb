FactoryBot.define do
  factory :employee_profile do
    name { 'MyString' }
    social_name { 'MyString' }
    cpf { 'MyString' }
    rg { 'MyString' }
    address { 'MyString' }
    email { 'MyString' }
    phone_number { 'MyString' }
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
