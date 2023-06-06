FactoryBot.define do
  factory :position do
    name { "MyString" }
    description { "MyString" }
    code { "MyString" }
    card_type_id { 1 }
    department { nil }
  end
end
