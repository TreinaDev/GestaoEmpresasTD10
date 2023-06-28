require 'rails_helper'

describe 'Usuário acessa página de detalhes de perfil de funcionários', type: :request do
  it 'enquanto gerente com sucesso' do
    create(:admin_user)
    company = create(:company)
    create(:manager_emails, company:)
    user_manager = create(:manager_user)

    department = create(:department, company:)
    position = create(:position, department_id: department.id)
    employee = create(:employee_profile, :employee, department_id: department.id, position_id: position.id)

    fake_response = double('faraday_response', status: 200, body: '{}')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)

    json_data = Rails.root.join('spec/support/json/cards2.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/cards/#{employee.cpf}").and_return(fake_response)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as user_manager
    get company_department_employee_profile_path(company_id: company.id, department_id: department.id, id: employee.id)

    expect(response).to have_http_status(:ok)
  end

  it 'enquanto admin sem sucesso' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, company:)

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
