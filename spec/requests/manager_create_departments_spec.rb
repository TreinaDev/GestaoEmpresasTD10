require 'rails_helper'

describe 'Criação de Departamento', type: :request do
  context 'Admin tenta criar departamento' do
    it 'e não tem permissão' do
      admin = create(:user, email: 'user@punti.com')
      company = create(:company)

      login_as admin

      post company_departments_path(company.id), params: {
        department: {
          name: 'A'
        }
      }

      follow_redirect!

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end

  context 'visitante tenta criar departamento' do
    it 'e não consegue pois precisa estar logado como manager' do
      company = create(:company)
      post company_departments_path(company.id), params: {
        department: {
          name: 'A'
        }
      }

      follow_redirect!

      expect(response.body).to include 'Para continuar, faça login ou registre-se.'
    end
  end

  context 'funcionário tenta criar departamento' do
    it 'e não tem permissão' do
      company = create(:company)
      department = create(:department, company:)
      position = create(:position, department:)
      employee_data = create(:employee_profile, :employee, position:, department:)
      employee_user = User.create!(
        email: employee_data.email,
        cpf: employee_data.cpf,
        password: '123456'
      )

      login_as employee_user
      post company_departments_path(company.id), params: {
        department: {
          name: 'A'
        }
      }

      follow_redirect!

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end

  context 'Manager tenta criar departamento de outra empresa' do
    it 'e não tem permissão' do
      company = create(:company)
      create(:manager_emails, company:)
      manager = create(:manager_user)
      create(:employee_profile, :manager, user: manager)
      second_company = create(:company, brand_name: 'Apple', domain: 'apple.com.br',
                                        registration_number: '10394460005884')

      login_as manager
      post company_departments_path(second_company.id), params: {
        department: {
          name: 'A'
        }
      }
      follow_redirect!

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end
end
