FactoryBot.define do
  factory :user do
    email { 'email@email.com' }
    cpf { '44429533768' }
    password { 'password' }
  end
end