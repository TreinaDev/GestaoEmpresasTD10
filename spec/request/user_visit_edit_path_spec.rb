require 'rails_helper'

describe 'Usuário visita tela de edição', type: :request do
  context 'enquanto admin' do
    it 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999',
                            email: 'company@apple.com',
                            domain: 'apple.com', status: true)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      company.save!

      login_as admin

      new_attributes = {
        brand_name: 'Novo nome fantasia',
        corporate_name: 'Nova razão social ',
        registration_number: '98.765.432/1000-85',
        address: 'Novo endereço',
        phone_number: '22 88888-8888',
        email: 'novoemail@company.com',
        domain: 'novodominio.com'
      }

      patch company_path(company), params: { company: new_attributes }

      company.reload

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to company_path(company)
      expect(company.brand_name).to eq(new_attributes[:brand_name])
      expect(company.corporate_name).to eq(new_attributes[:corporate_name])
      expect(company.registration_number).to eq(new_attributes[:registration_number])
      expect(company.address).to eq(new_attributes[:address])
      expect(company.phone_number).to eq(new_attributes[:phone_number])
      expect(company.email).to eq(new_attributes[:email])
      expect(company.domain).to eq(new_attributes[:domain])
    end
  end

  context 'sem sucesso' do
    it 'enquanto gerente' do
      admin = User.create!(email: 'admin@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      Manager.create!(email: 'manager@apple.com', created_by: admin)
      manager = User.create!(email: 'manager@apple.com', role: :manager, password: '123456', cpf: '51959723030')
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999',
                            email: 'company@apple.com',
                            domain: 'apple.com', status: false)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      company.save!

      login_as manager
      get edit_company_path(company)

      expect(response).to have_http_status(:forbidden)
      expect(response.body).to include 'Apenas administradores podem executar essa ação'
    end

    it 'enquanto funcionário' do
      employee = User.create!(email: 'employee@apple.com', role: :employee, password: '123456', cpf: '02324252481')
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999',
                            email: 'company@apple.com',
                            domain: 'apple.com', status: true)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      company.save!

      login_as employee
      get edit_company_path(company)

      expect(response).to have_http_status(:forbidden)
      expect(response.body).to include 'Apenas administradores podem executar essa ação'
    end
  end
end
