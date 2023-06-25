require 'rails_helper'

feature 'Gerente visualiza cargo' do
  scenario 'Com tipo de cartão obsoleto' do
    company = create(:company)
    department = create(:department, company:)

    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")

    position = create(:position, name: 'Estagiário', description: 'Faz tudo', code: 'EST001', card_type_id: 9,
                                 department:)
    create(:employee_profile, :manager, department:, position:, user: manager_user)

    fake_status = double('faraday_status', status: 200, body: '{}')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_status)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as(manager_user)
    visit company_department_position_path(company_id: company.id, department_id: department.id, id: Position.first.id)

    expect(current_path).to eq company_department_position_path(company_id: company.id, department_id: department.id,
                                                                id: Position.first.id)
    expect(page).to have_content 'Nome: Estagiário'
    expect(page).to have_content 'Descrição: Faz tudo'
    expect(page).to have_content 'Tipo de cartão: Cartão Inválido'
    expect(page).to have_content 'Departamento: Departamento de RH'
  end
end
