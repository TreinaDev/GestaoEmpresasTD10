require 'rails_helper'

describe 'Edição de Departamento', type: :request do
  context 'Admin tenta editar departamento' do
    it 'e não tem permissão' do
      admin = create(:user, email: 'user@punti.com')
      company = create(:company)
      department = create(:department, company:)

      login_as admin

      get edit_company_department_path(company.id, department.id)

      follow_redirect!

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end

  context 'visitante tenta editar departamento' do
    it 'e não consegue pois precisa estar logado como manager' do
      company = create(:company)
      department = create(:department, company:)

      get edit_company_department_path(company.id, department.id)

      follow_redirect!

      expect(response.body).to include 'Para continuar, faça login ou registre-se.'
    end
  end

  context 'funcionário tenta editar departamento' do
    it 'e não tem permissão' do
      company = create(:company)
      department = create(:department, company:)
      position = create(:position, department:)
      create(:manager_emails, company:)
      create(:employee_profile, :employee, department:, position:)
      employee_user = create(:employee_user)

      login_as employee_user
      get edit_company_department_path(company.id, department.id)

      follow_redirect!
      follow_redirect!

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end

  context 'Manager tenta editar departamento de outra empresa' do
    it 'e não tem permissão' do
      company = create(:company)
      create(:manager_emails, company:)
      manager = create(:manager_user)
      create(:employee_profile, :manager, user: manager)
      second_company = create(:company, brand_name: 'Apple', domain: 'apple.com.br',
                                        registration_number: '10394460005884')
      second_department = create(:department, company: second_company)

      login_as manager
      get edit_company_department_path(second_company.id, second_department.id)
      follow_redirect!
      follow_redirect!

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end
end
