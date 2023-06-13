FactoryBot.define do
  factory :department do
    name { 'RH' }
    description { 'Recursos Humanos' }
    code { 'CODIGO123' }
    company
  end
end
