FactoryBot.define do
  factory :department do
    name { 'RH' }
    description { 'Departamento de RH' }
    code { 'ABC123' }
    company { nil }
  end
end
