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
      employee_data = create(:employee_profile, position:, department:)
      employee_user = User.create!(
        email: employee_data.email,
        cpf: employee_data.cpf,
        password: '123456'
      )

      login_as employee_user
      get edit_company_department_path(company.id, department.id)

      follow_redirect!

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end
end
