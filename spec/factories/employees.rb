FactoryBot.define do
  factory :employee do
    name { 'João Pereira Neto' }
    social_name {}
    cpf { '01341598020' }
    rg { '182132754' }
    address { 'Rua Ipiranga, 3123' }
    email { 'joaozinho@gmail.com' }
    phone_number { '99981999929' }
    status { :unblocked }
    birth_date { '1997-06-06' }
    admission_date { '2023-06-06' }
    dismissal_date { '2023-06-06' }
    marital_status { 1 }
    department { nil }
    user { nil }
    position { nil }
  end
  # status: 'blocked', department_id: department.id, position_id: position.id,
  # user_id: manager.id
end
