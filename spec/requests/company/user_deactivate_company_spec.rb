require 'rails_helper'

describe 'Usuário desativa empresa', type: :request do
  context 'enquanto admin' do
    it 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = FactoryBot.create(:company, active: true)

      login_as admin
      put deactivate_company_path(company)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to company_path(company)
      expect(company.reload.active).to eq false
    end
  end

  context 'enquanto gerente' do
    it 'sem sucesso' do
      company = create(:company)
      create(:manager_emails, company:)
      manager = create(:manager_user)
      create(:employee_profile, :manager, user: manager)

      login_as manager
      put deactivate_company_path(company)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
      expect(company.reload.active).to eq true
    end
  end

  context 'enquanto funcionário' do
    it 'sem sucesso' do
      company = FactoryBot.create(:company, active: true)
      department = FactoryBot.create(:department, company:)
      position = FactoryBot.create(:position, department:)
      FactoryBot.create(:employee_profile, position:, department:, email: 'employee@apple.com', cpf: '02324252481')
      employee = User.create!(email: 'employee@apple.com', password: '123456', cpf: '02324252481')

      login_as employee
      put deactivate_company_path(company)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
      expect(company.reload.active).to eq true
    end
  end
end
