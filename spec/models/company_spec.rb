require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#valido?' do
    it 'inválido quando nome fantasia fica em branco' do
      company = Company.new(brand_name: '', corporate_name: 'Apple LTDA', registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999', email: 'company@apple.com',
                            domain: 'apple.com', status: true)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      expect(company).not_to be_valid
      expect(company.errors[:brand_name]).to include('não pode ficar em branco')
    end
    it 'inválido quando razão social fica em branco' do
      company = Company.new(brand_name: 'Apple', corporate_name: '', registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999', email: 'company@apple.com',
                            domain: 'apple.com', status: true)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      expect(company).not_to be_valid
      expect(company.errors[:corporate_name]).to include('não pode ficar em branco')
    end

    it 'inválido quando cnpj fica em branco' do
      company = Company.new(brand_name: '', corporate_name: 'Apple LTDA', registration_number: '',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999', email: 'company@apple.com',
                            domain: 'apple.com', status: true)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      expect(company).not_to be_valid
      expect(company.errors[:registration_number]).to include('não pode ficar em branco')
    end

    it 'inválido quando endereço fica em branco' do
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: '', phone_number: '11 99999-9999', email: 'company@apple.com',
                            domain: 'apple.com', status: true)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      expect(company).not_to be_valid
      expect(company.errors[:address]).to include('não pode ficar em branco')
    end

    it 'inválido quando telefone fica em branco' do
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '', email: 'company@apple.com',
                            domain: 'apple.com', status: true)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      expect(company).not_to be_valid
      expect(company.errors[:phone_number]).to include('não pode ficar em branco')
    end

    it 'inválido quando e-mail fica em branco' do
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999', email: '',
                            domain: 'apple.com', status: true)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      expect(company).not_to be_valid
      expect(company.errors[:email]).to include('não pode ficar em branco')
    end

    it 'inválido quando domínio fica em branco' do
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999', email: 'company@apple.com',
                            domain: '', status: true)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      expect(company).not_to be_valid
      expect(company.errors[:domain]).to include('não pode ficar em branco')
    end

    it 'inválido quando logo fica em branco' do
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999', email: 'company@apple.com',
                            domain: 'apple.com', status: true)
      expect(company).not_to be_valid
      expect(company.errors[:logo]).to include('não pode ficar em branco')
    end
  end
end
