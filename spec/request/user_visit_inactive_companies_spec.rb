require 'rails_helper'

describe 'Usuário visita tela de empresas inativas', type: :request do
  context 'enquanto admin' do
    it 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')

      login_as admin
      get inactives_companies_path

      expect(response).to have_http_status(:ok)
    end
  end

  context 'enquanto gerente' do
    it 'sem sucesso' do
      admin = User.create!(email: 'admin@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = create(:company, domain: 'apple.com')
      Manager.create!(email: 'manager@apple.com', created_by: admin, company:)
      manager = User.create!(email: 'manager@apple.com', role: :manager, password: '123456', cpf: '51959723030')

      login_as manager
      get inactives_companies_path

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
    end
  end

  context 'enquanto funcionário' do
    it 'sem sucesso' do
      company = FactoryBot.create(:company)
      department = FactoryBot.create(:department, company:)
      position = FactoryBot.create(:position, department:)
      FactoryBot.create(:employee_profile, position:, department:, email: 'employee@apple.com', cpf: '02324252481')
      employee = User.create!(email: 'employee@apple.com', password: '123456', cpf: '02324252481')

      login_as employee
      get inactives_companies_path

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
    end
  end
end
