FactoryBot.define do
  factory :position do
    name { 'Gerente' }
    description { 'Gerenta da empresa' }
    code { 'BABABA123' }
    card_type_id { 1 }
    department { nil }
  end
end
