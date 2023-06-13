require 'rails_helper'

describe 'Usuário para ativar empresa', type: :request do
  context 'precisa ser admin' do
    it 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999',
                            email: 'company@apple.com',
                            domain: 'apple.com', status: false)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      company.save!

      login_as admin
      put activate_company_path(company)
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(company.reload.status).to eq true
    end

    it 'e falha enquanto gerente' do
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
      put activate_company_path(company)
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
      expect(company.reload.status).to eq false
    end

    it 'e falha enquanto funcionário' do
      company = FactoryBot.create(:company, status: false)
      department = FactoryBot.create(:department, company:)
      position = FactoryBot.create(:position, department:)
      FactoryBot.create(:employee, position:, department:, email: 'employee@apple.com', cpf: '02324252481')
      employee = User.create!(email: 'employee@apple.com', password: '123456', cpf: '02324252481')

      login_as employee
      put activate_company_path(company)
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
      expect(company.reload.status).to eq false
    end
  end
end
