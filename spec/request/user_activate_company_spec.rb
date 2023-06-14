require 'rails_helper'

describe 'Usuário para ativar empresa', type: :request do
  context 'precisa ser admin' do
    it 'e ativa com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = FactoryBot.create(:company, active: false)

      login_as admin
      put activate_company_path(company)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to company_path(company)
      expect(company.reload.active).to eq true
    end

    it 'e falha enquanto gerente' do
      admin = User.create!(email: 'admin@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      Manager.create!(email: 'manager@apple.com', created_by: admin)
      manager = User.create!(email: 'manager@apple.com', role: :manager, password: '123456', cpf: '51959723030')
      company = FactoryBot.create(:company, active: false)

      login_as manager
      put activate_company_path(company)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
      expect(company.reload.active).to eq false
    end

    it 'e falha enquanto funcionário' do
      company = FactoryBot.create(:company, active: false)
      department = FactoryBot.create(:department, company:)
      position = FactoryBot.create(:position, department:)
      FactoryBot.create(:employee, position:, department:, email: 'employee@apple.com', cpf: '02324252481')
      employee = User.create!(email: 'employee@apple.com', password: '123456', cpf: '02324252481')

      login_as employee
      put activate_company_path(company)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
      expect(company.reload.active).to eq false
    end
  end
end
