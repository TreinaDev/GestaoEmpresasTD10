require 'rails_helper'

feature 'Gerente acessa perfil do funcionário' do
  scenario 'e bloqueia cartão de funcionário' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    create(:employee_profile, :manager, department:, position:, user: manager_user, name: 'arthur silva',
                                        social_name: 'arthur arthur')
    employee = create(:employee_profile, position:, department_id: position.department.id,
                                         status: 'unblocked', email: "funcionario@#{company.domain}",
                                         cpf: '90900938005',
                                         card_status: true)

    json_data = Rails.root.join('spec/support/json/cards.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/cards/90900938005').and_return(fake_response)

    json_data2 = '{}'
    fake_response2 = double('faraday_response', status: 200, body: json_data2)
    allow(Faraday).to receive(:patch).with("http://localhost:4000/api/v1/cards/#{JSON.parse(fake_response.body)['id']}/deactivate").and_return(fake_response2)

    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response2)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response2)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)
    within("div#department#{department.id}") do
      click_on 'Ver departamento'
    end
    page.find("#employee#{employee.id}").click
    within('div#user_card') do
      click_on 'Bloquear Cartão'
    end

    expect(current_path).to eq company_department_employee_profile_path(company_id: company.id,
                                                                        department_id: department.id,
                                                                        id: employee.id)
    expect(page).to have_content 'Cartão bloqueado com sucesso'
  end

  scenario 'e desbloqueia cartão de funcionário' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    create(:employee_profile, :manager, department:, position:, user: manager_user, name: 'arthur silva',
                                        social_name: 'arthur arthur')
    employee = create(:employee_profile, position:, department_id: position.department.id,
                                         status: 'unblocked', email: "funcionario@#{company.domain}",
                                         cpf: '90900938005',
                                         card_status: true)

    json_data = Rails.root.join('spec/support/json/cards2.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/cards/#{employee.cpf}").and_return(fake_response)

    json_data2 = '{}'
    fake_response2 = double('faraday_response', status: 200, body: json_data2)
    allow(Faraday).to receive(:patch).with("http://localhost:4000/api/v1/cards/#{JSON.parse(fake_response.body)['id']}/activate").and_return(fake_response2)

    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response2)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response2)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)
    within("div#department#{department.id}") do
      click_on 'Ver departamento'
    end
    page.find("#employee#{employee.id}").click
    within('div#user_card') do
      click_on 'Desbloquear Cartão'
    end

    expect(current_path).to eq company_department_employee_profile_path(company_id: company.id,
                                                                        department_id: department.id,
                                                                        id: employee.id)
    expect(page).to have_content 'Cartão desbloqueado com sucesso'
  end

  scenario 'e serviço está indisponível' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    create(:employee_profile, :manager, department:, position:, user: manager_user, name: 'arthur silva',
                                        social_name: 'arthur arthur')
    create(:employee_profile, position:, department_id: position.department.id,
                              status: 'unblocked', email: "funcionario@#{company.domain}",
                              cpf: '90900938005', card_status: true)

    json_data = Rails.root.join('spec/support/json/cards.json').read
    fake_response = double('faraday_response', status: 500, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)
    within("div#department#{department.id}") do
      click_on 'Ver departamento'
    end

    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Sistema indisponível no momento, por favor tente mais tarde'
    expect(page).to_not have_button 'Bloquear Cartão'
  end
end
