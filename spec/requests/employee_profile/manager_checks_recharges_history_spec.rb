require 'rails_helper'

describe 'Gerente tenta ver historico de recarga de funcionário sem cartão' do
  it 'e é redirecionado para perfil do funcionário' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company:)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, name: 'Vanessa Camargo',
                                        marital_status: 1, department:, position:)
    employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento',
                                                            marital_status: 1, department:, position:)

    login_as manager
    get recharge_history_company_department_employee_profile_path(company.id, department.id, employee_profile.id)

    expect(response).to redirect_to company_department_employee_profile_path(company.id, department.id,
                                                                             employee_profile.id)
    expect(flash[:notice]).to eq('Este funcionário não possui cartão')
  end
end
