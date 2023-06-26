require 'rails_helper'

feature 'Manager vê lista de cargos de um departamento' do
  scenario 'Com sucesso' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    create(:employee_profile, :manager, user: manager)
    department = create(:department, company:)
    create(:position, department_id: department.id, name: 'Tester')
    second_department = create(:department, company:)
    create(:position, department_id: second_department.id, name: 'Programador')

    json_data = '{}'
    fake_status = double('faraday_status', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_status)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as manager
    visit company_department_positions_path(company, second_department)

    expect(page).to have_content 'Programador'
    expect(page).not_to have_content 'Tester'
  end

  scenario 'E não há cargos' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    create(:employee_profile, :manager, user: manager)
    department = create(:department, company:)
    create(:position, department_id: department.id, name: 'Tester')
    second_department = create(:department, company:)

    json_data = '{}'
    fake_status = double('faraday_status', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_status)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as manager
    visit company_department_positions_path(company, second_department)

    expect(page).not_to have_content 'Tester'
    expect(page).to have_content 'Nenhum cargo neste departamento.'
  end
end
