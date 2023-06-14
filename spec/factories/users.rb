FactoryBot.define do
  factory :user do
    email { 'email@email.com' }
    cpf { '20603758606' }
    password { 'password' }
  end
end
