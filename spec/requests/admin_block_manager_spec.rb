require 'rails_helper'

describe 'Bloqueio de manager', type: :request do
  context 'Admin tenta bloquear Manager' do
    it 'Com sucesso' do
      admin = create(:admin_user)
      company = create(:company)
      create(:manager_emails, created_by: admin, company:)
      create(:manager_user)
      department = create(:department, company_id: company.id)
      position = create(:position, department_id: department.id)
      manager = create(:employee_profile, :manager, status: 'unblocked', department_id: department.id, position:)

      login_as admin
      get '/companies/1/manager'
      manager.update(status: :blocked)
      manager.reload

      expect(manager.status).to eq 'blocked'
    end

    it 'Sem sucesso' do
      admin = create(:admin_user)
      company = create(:company)
      create(:manager_emails, created_by: admin, company:)
      manager = create(:manager_user)
      department = create(:department, company_id: company.id)
      position = create(:position, department_id: department.id)
      create(:employee_profile, :manager, status: 'blocked', department_id: department.id, user_id: manager.id,
                                          position:)
      allow_any_instance_of(User).to receive(:block!).and_return(false)

      login_as admin
      patch block_user_path(manager.id)

      expect(flash[:alert]).to eq('Não foi possível bloquear o usuário')
    end
  end

  context 'Manager tenta bloquear outro Manager' do
    it 'e não tem permissão' do
      admin = create(:user, email: 'user@punti.com')
      company = create(:company, domain: 'gmail.com')
      create(:manager_emails, created_by: admin, company:, email: 'joaozinho@gmail.com')
      manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
      department = create(:department, company_id: company.id)
      position = create(:position, department_id: department.id)
      create(:employee_profile, :employee, status: 'unblocked', department_id: department.id, user_id: manager.id,
                                           position:)

      login_as manager
      get users_path

      follow_redirect!
      follow_redirect!

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end

  context 'Employee tenta bloquear Manager' do
    it 'e não tem permissão' do
      admin = create(:user, email: 'user@punti.com')
      company = create(:company, domain: 'gmail.com')
      create(:manager_emails, created_by: admin, company:, email: 'joaozinho@gmail.com')
      manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
      department = create(:department, company:)
      position = create(:position, department:)
      create(:employee_profile, :employee, status: 'unblocked', department:, user: manager, position:)
      create(:employee_profile, :employee, department:, cpf: '27549954046', position:)
      employee = create(:user, cpf: '27549954046', email: 'employee@gmail.com')

      login_as employee
      get users_path

      follow_redirect!
      follow_redirect!

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end
end
