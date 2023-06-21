require 'rails_helper'

describe 'Usuário visita tela de empresas ativas', type: :request do
  context 'enquanto admin' do
    it 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')

      login_as admin
      get companies_path

      expect(response).to have_http_status(:ok)
    end
  end

  context 'enquanto gerente' do
    it 'sem sucesso' do
      admin = create(:user, email: 'admin@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = create(:company)
      create(:manager_emails, email: 'manager@campuscode.com.br', created_by: admin, company:)
      manager = create(:user, email: 'manager@campuscode.com.br', role: :manager, password: '123456',
                              cpf: '51959723030')

      login_as manager
      get companies_path

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
    end
  end

  context 'enquanto funcionário' do
    it 'sem sucesso' do
      company = create(:company, active: false)
      department = create(:department, company:)
      position = create(:position, department:)
      create(:employee_profile, position:, department:, email: 'employee@campuscode.com.br', cpf: '02324252481')
      employee = create(:user, email: 'employee@campuscode.com.br', password: '123456', cpf: '02324252481')

      login_as employee
      get companies_path

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
    end
  end
end
