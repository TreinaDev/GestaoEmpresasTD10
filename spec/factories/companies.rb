FactoryBot.define do
  factory :company do
    brand_name { 'Campus Code' }
    corporate_name { 'Campus Code Treinamentos LTDA' }
    sequence(:registration_number) { |n| "15.394.460/000#{n}-87" }
    address { 'Rua da tecnologia, nº 1500' }
    phone_number { '1130302525' }
    email { 'contato@campuscode.com.br' }
    domain { 'campuscode.com.br' }
    logo { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/images/logo.png'), 'image/png') }
    active { true }

    trait :with_department_and_position do
      after(:create) do |company, _|
        company.departments.create(name: "Departamento de RH", description: 'Recursos Humanos')
        company.positions.create(name: 'Gerente', code: 'GER003', description: 'Gerente Geral')
      end
    end
  end
end