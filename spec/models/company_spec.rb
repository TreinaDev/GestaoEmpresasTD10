require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#valido?' do
    it 'inválido quando os campos ficam em branco' do
      company = Company.new(active: true)

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

  describe '#registration_number' do
    it 'e único' do
      company_params = {
        company: {
          registration_number: '00.394.460/0058-87',
          brand_name: 'Campus Code',
          corporate_name: 'Campus Code Treinamentos LTDA',
          active: nil
        }
      }

      fake_response = double('faraday_response', success?: true, status: 200)
      allow(Faraday).to receive(:post).with('http://localhost:5000/api/v1/companies', company_params).and_return(fake_response)

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

  describe '#after_create' do
    it 'Método send_new_company_to_loja' do
      company_params = {
        company: {
          registration_number: '10394460005887',
          brand_name: 'Campus Code',
          corporate_name: 'Campus Code Treinamentos LTDA',
          active: true
        }
      }
      fake_response = double('faraday_response', success?: true, status: 200)
      allow(Faraday).to receive(:post).with('http://localhost:5000/api/v1/companies', company_params).and_return(fake_response)

      create(:company, registration_number: '10394460005887',
                       brand_name: 'Campus Code',
                       corporate_name: 'Campus Code Treinamentos LTDA',
                       active: true)

      expect(Faraday).to have_received(:post).with('http://localhost:5000/api/v1/companies', company_params)
    end
  end
end