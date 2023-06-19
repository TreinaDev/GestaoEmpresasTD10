FactoryBot.define do
  factory :manager do
    email { 'manager@microsoft.com' }
    created_by { association :user, email: 'email@punti.com' }
    company
  end
end
