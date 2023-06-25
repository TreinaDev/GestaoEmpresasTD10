require 'rails_helper'

describe 'Usuário acessa página de cadastro de perfil de funcionários', type: :request do
  it 'enquanto gerente com sucesso' do
    company = create(:company)
    create(:manager_emails, company:)
    manager = create(:manager_user)
    department = create(:department)
    create(:employee_profile, :manager, user: manager, department:)

    login_as manager
    get new_company_department_employee_profile_path(company_id: company.id, department_id: department.id)

    expect(response).to have_http_status(:ok)
  end

  it 'enquanto admin sem sucesso' do
    admin = create(:user, email: 'manoel@punti.com')
    company = create(:company)
    department = create(:department, company:)

    login_as admin
    get new_company_department_employee_profile_path(company_id: company.id, department_id: department.id)

    expect(response).to have_http_status(:found)
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
  end

  it 'enquanto funcionário sem sucesso' do
    company = create(:company, active: false)
    department = create(:department, company:)
    position = create(:position, department:)
    create(:employee_profile, :employee, position:, department:, cpf: '02324252481')
    employee = create(:user, cpf: '02324252481', email: 'employee@campuscode.com.br')

    login_as employee
    get new_company_department_employee_profile_path(company_id: company.id, department_id: department.id)

    expect(response).to have_http_status(:found)
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
  end
end
