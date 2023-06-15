FactoryBot.define do
  factory :department do
    name { 'RH' }
    description { 'Recursos Humanos' }
    code { 'COD123' }
    company
  end
end
