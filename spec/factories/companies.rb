FactoryBot.define do
  factory :company do
    brand_name { 'Campus Code' }
    corporate_name { 'Campus Code Treinamentos LTDA' }
    registration_number { '10.394.460/0058-87' }
    address { 'Rua da tecnologia, nº 1500' }
    phone_number { '1130302525' }
    email { 'contato@campuscode.com.br' }
    domain { 'campuscode.com.br' }
    logo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'images', 'logo.png'), 'image/png') }

    status { true }
  end
end
