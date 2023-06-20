FactoryBot.define do
  factory :manager_emails do
    email { 'manager@microsoft.com' }
    created_by { association :user, email: 'email@punti.com' }
    company
  end
end
