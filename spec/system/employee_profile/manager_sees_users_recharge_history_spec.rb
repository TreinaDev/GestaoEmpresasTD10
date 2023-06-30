require 'rails_helper'

feature 'Gerente vê histórico de recargas do funcionário' do
  scenario 'Com sucesso' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company:)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, name: 'Vanessa Camargo',
                                        marital_status: 1, department:,
                                        position:, user: manager)
    employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento',
                                                            marital_status: 1, department:, position:,
                                                            card_status: true)
    recharge1 = RechargeHistory.create(value: 500, employee_profile:, creator: manager)
    RechargeHistory.create(value: 600, employee_profile:, creator: manager)
    RechargeHistory.create(value: 700, employee_profile:, creator: manager)

    json_data = Rails.root.join('spec/support/json/cards.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/cards/#{employee_profile.cpf}").and_return(fake_response)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as(manager)
    visit company_department_employee_profile_path(company.id, department.id, employee_profile.id)
    click_on 'Histórico de Recarga'

    expect(page).to have_content 'Histórico de recarga'
    expect(page).to have_content 'Funcionário: Roberto Carlos Nascimento'
    expect(page).to have_content 'R$ 500,00'
    expect(page).to have_content 'R$ 600,00'
    expect(page).to have_content 'R$ 700,00'
    expect(page).to have_content I18n.l(recharge1.created_at, format: :short)
  end

  scenario 'Sem sucesso' do
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

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    json_data = Rails.root.join('spec/support/json/cards2.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/cards/#{employee_profile.cpf}").and_return(fake_response)

    login_as(manager)
    visit company_department_employee_profile_path(company.id, department.id, employee_profile.id)

    expect(page).not_to have_link 'Histórico de recarga'
    expect(page).to have_content 'Funcionário não possui cartão'
  end
end
