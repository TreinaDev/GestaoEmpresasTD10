FactoryBot.define do
  factory :user do
    role { 1 }
    cpf { '85218947083' }
    email { 'zezinho@gmail.com' }
    password { '12345678' }
  end
end
