require 'rails_helper'

describe 'Usuário acessa página de detalhes de perfil de funcionários', type: :request do
  it 'enquanto gerente com sucesso' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager, company:)
    user_manager = create(:manager_user)

    department = create(:department, company:)
    position = create(:position, department_id: department.id)
    employee = create(:employee_profile, :employee, department_id: department.id, position_id: position.id)

    login_as user_manager
    get company_department_employee_profile_path(company_id: company.id, department_id: department.id, id: employee.id)

    expect(response).to have_http_status(:ok)
  end

  it 'enquanto admin sem sucesso' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager, company:)

    department = create(:department, company:)
    position = create(:position, department_id: department.id)
    employee = create(:employee_profile, :employee, department_id: department.id, position_id: position.id)
    create(:employee_user)

    login_as admin
    get company_department_employee_profile_path(company_id: company.id, department_id: department.id, id: employee.id)

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
    get company_department_employee_profile_path(company_id: company.id, department_id: department.id, id: employee.id)

    expect(response).to have_http_status(:found)
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
  end
end
