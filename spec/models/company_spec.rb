require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#registration_number' do
    it 'e único' do
      Company.create!(brand_name: 'Campus Code', corporate_name: 'Campus Code Treinamentos LTDA',
                      registration_number: '00.394.460/0058-87', address: 'Rua da tecnologia, nº 1500',
                      phone_number: '1130302525', email: 'contato@campuscode.com.br',
                      domain: 'campuscode.com.br',
                      logo: {
                        io: Rails.root.join('spec/support/images/logo.png').open,
                        filename: 'logo.png', content_type: 'image/png'
                      })

      other_company = Company.new(brand_name: 'Cod3', corporate_name: 'Cod3 Treinamentos LTDA',
                                  registration_number: '00.394.460/0058-87', address: 'Rua da tecnologia, nº 3000',
                                  phone_number: '1130302525', email: 'contato@cod3.com.br',
                                  domain: 'cod3.com.br',
                                  logo: {
                                    io: Rails.root.join('spec/support/images/logo.png').open, filename: 'logo.png',
                                    content_type: 'image/png'
                                  })

      other_company.valid?

      expect(other_company.errors[:registration_number].size).to eq 1
      expect(other_company.errors[:registration_number]).to include 'já está em uso'
    end
  end
  describe '#valido?' do
    it 'inválido quando nome fantasia fica em branco' do
      company = Company.new(status: true)

      expect(company).not_to be_valid
      expect(company.errors[:brand_name]).to include('não pode ficar em branco')
      expect(company.errors[:corporate_name]).to include('não pode ficar em branco')
      expect(company.errors[:registration_number]).to include('não pode ficar em branco')
      expect(company.errors[:address]).to include('não pode ficar em branco')
      expect(company.errors[:phone_number]).to include('não pode ficar em branco')
      expect(company.errors[:email]).to include('não pode ficar em branco')
      expect(company.errors[:domain]).to include('não pode ficar em branco')
      expect(company.errors[:brand_name]).to include('não pode ficar em branco')
      expect(company.errors[:logo]).to include('não pode ficar em branco')
    end
  end
end
