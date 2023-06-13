FactoryBot.define do
  factory :company do
    brand_name { 'Google' }
    corporate_name { 'Google LTDA' }
    registration_number { '123456789' }
    address { 'Rua abigail, 13' }
    phone_number { '90908765433' }
    email { 'contato@gmail.com' }
    domain { 'gmail.com' }
    status { true }
  end
end
