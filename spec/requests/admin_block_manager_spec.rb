require 'rails_helper'

describe 'Bloqueio de manager', type: :request do
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

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end
end
