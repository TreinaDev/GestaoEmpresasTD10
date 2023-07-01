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
    employee = create(:employee_profile, email: 'employee@microsoft.com',
                                         cpf: '10323973060', department_id: department.id,
                                         position_id: position.id)
    employee_user = create(:employee_user, email: 'employee@microsoft.com', cpf: '10323973060')
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
    follow_redirect!

    expect(response).to have_http_status(:ok)
    expect(response.body).to include 'Usuário sem permissão para executar essa ação'
  end

  it 'e falha pois funcionário ja esta desligado' do
    admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
    company = create(:company)

    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user, cpf: '14101674027')
    department = create(:department, company:)
    position = create(:position, department_id: department.id)
    employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento', marital_status: 1,
                                                            dismissal_date: 1.day.from_now, department:,
                                                            position:, status: 'fired')

    login_as manager
    post fired_company_department_employee_profiles_path(company_id: company.id, department_id: department.id,
                                                         id: employee_profile.id)

    expect(response).to redirect_to company_department_employee_profile_path(company_id: company.id,
                                                                             department_id: department.id,
                                                                             id: employee_profile.id)
    expect(flash[:alert]).to eq 'Funcionário já desligado'
  end
end
