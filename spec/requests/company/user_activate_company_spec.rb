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
      company = create(:company)
      create(:manager_emails, company:)
      manager = create(:manager_user)
      create(:employee_profile, :manager, user: manager)

      company.active = false
      company.save!

      login_as manager
      put activate_company_path(company)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
      expect(company.reload.active).to eq false
    end

    it 'e falha enquanto funcionário' do
      company = create(:company, active: false)
      department = create(:department, company:)
      position = create(:position, department:)
      create(:employee_profile, position:, department:, email: 'employee@microsoft.com', cpf: '02324252481')
      employee = create(:user, email: 'employee@microsoft.com', password: '123456', cpf: '02324252481')

      login_as employee
      put activate_company_path(company)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
      expect(company.reload.active).to eq false
    end
  end
end
