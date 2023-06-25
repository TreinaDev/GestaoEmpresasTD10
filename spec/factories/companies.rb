FactoryBot.define do
  factory :company do
    brand_name { 'Campus Code' }
    corporate_name { 'Campus Code Treinamentos LTDA' }
    sequence(:registration_number) { |n| "15.394.460/000#{n}-87" }
    address { 'Rua da tecnologia, nº 1500' }
    phone_number { '1130302525' }
    email { 'contato@microsoft.com' }
    domain { 'microsoft.com' }
    logo { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/images/logo.png'), 'image/png') }
    active { true }

    trait :with_department do
      after(:create) do |company, _|
        company.departments.create(name: 'Departamento de RH', description: 'Recursos Humanos')
      end
    end
  end
end
