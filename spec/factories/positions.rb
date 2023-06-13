FactoryBot.define do
  factory :position do
    name { 'Estagiário' }
    description { 'Faz tudo' }
    code { 'EST001' }
    card_type_id { 1 }
    department
  end
end
