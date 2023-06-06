FactoryBot.define do
  factory :company do
    brand_name { 'MyString' }
    corporate_name { 'MyString' }
    registration_number { 'MyString' }
    address { 'MyString' }
    phone_number { 'MyString' }
    email { 'MyString' }
    domain { 'MyString' }
    status { false }
  end
end
