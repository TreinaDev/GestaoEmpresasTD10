require 'rails_helper'

describe 'Usuário tenta desligar funcionário', type: :request do
  it 'enquanto gerente com sucesso' do
    admin = create(:user, email: 'admin@punti.com')
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    user_manager = create(:manager_user)
    department = create(:department, company:)
    position = create(:position, department_id: department.id)
    employee = create(:employee_profile, :manager, department_id: department.id, position_id: position.id)
    date = 1.day.from_now

    login_as user_manager
    post fired_company_department_employee_profiles_path(
      company_id: company.id,
      department_id: department.id,
      id: employee.id
    ), params: {
      fired: {
        date:
      }
    }

    follow_redirect!

    expect(response).to have_http_status(:ok)
    expect(response.body).to include 'Roberto Carlos Nascimento'
    expect(response.body).to include 'Data de Demissão:'
    expect(response.body).to include date.strftime('%d/%m/%Y')
  end

  it 'enquanto admin sem sucesso' do
    admin = create(:admin_user)
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department_id: department.id)
    employee = create(:employee_profile, :employee, department_id: department.id, position_id: position.id)
    date = 1.day.from_now

    login_as admin
    post fired_company_department_employee_profiles_path(
      company_id: company.id,
      department_id: department.id,
      id: employee.id
    ), params: {
      fired: {
        date:
      }
    }

    follow_redirect!

    expect(response).to have_http_status(:ok)
    expect(response.body).to include 'Usuário sem permissão para executar essa ação'
  end

  it 'enquanto funcionário sem sucesso' do
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department_id: department.id)
    employee = create(:employee_profile, email: 'email@gmail.com', cpf: '10323973060', department_id: department.id,
                                         position_id: position.id)
    employee_user = create(:employee_user, email: 'email@gmail.com', cpf: '10323973060')
    employee.user = employee_user
    employee.save!

    date = 1.day.from_now

    login_as employee_user
    post fired_company_department_employee_profiles_path(
      company_id: company.id,
      department_id: department.id,
      id: employee.id
    ), params: {
      fired: {
        date:
      }
    }

    follow_redirect!

    expect(response).to have_http_status(:ok)
    expect(response.body).to include 'Usuário sem permissão para executar essa ação'
  end
end
