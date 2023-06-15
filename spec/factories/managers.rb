FactoryBot.define do
  factory :manager do
    email { 'email@email.com' }
    created_by { association :user, email: 'email@punti.com' }
    company
  end
end
