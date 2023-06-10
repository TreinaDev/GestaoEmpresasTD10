require 'rails_helper'

describe 'Usuário desativa empresa', type: :request do
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
      put "/companies/#{company.id}/deactivate"

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to company_path(company)
      expect(company.reload.status).to eq false
    end
  end

  context 'enquanto gerente' do
    it 'sem sucesso' do
      admin = User.create!(email: 'admin@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      Manager.create!(email: 'manager@apple.com', created_by: admin)
      manager = User.create!(email: 'manager@apple.com', role: :manager, password: '123456', cpf: '51959723030')
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999',
                            email: 'company@apple.com',
                            domain: 'apple.com', status: true)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      company.save!

      login_as manager
      put "/companies/#{company.id}/deactivate"

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to root_path
      expect(company.reload.status).to eq true
    end
  end

  context 'enquanto funcionário' do
    it 'sem sucesso' do
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
      put "/companies/#{company.id}/deactivate"

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to root_path
      expect(company.reload.status).to eq true
    end
  end
end
