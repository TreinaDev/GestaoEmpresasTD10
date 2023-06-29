require 'rails_helper'

feature 'Gerente vai para index do departamento' do
  scenario 'e vê todos os funcionários do departamento' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    create(:employee_profile, :manager, department:, position:, user: manager_user)
    create(:employee_profile, position:, department_id: position.department.id,
                              status: 'unblocked', email: "funcionario@#{company.domain}", cpf: '90900938005')

    create(:user, email: "funcionario@#{company.domain}", password: 'password', cpf: '90900938005')

    fake_response = double('faraday_response', status: 200, body: '{}')
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)

    within('#department1') do
      click_on 'Ver departamento'
    end

    expect(current_path).to eq company_department_path(company_id: company.id, id: department.id)
    expect(page).to have_content 'Nome: Departamento de RH'
    expect(page).to have_content 'Roberto Carlos Nascimento'
    expect(page).to have_button 'Solicitar Cartão'
  end

  scenario 'e solicita cartão com sucesso' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:)
    manager_user = create(:manager_user)
    position = create(:position, department:)
    employee_profile = create(:employee_profile, :manager, position:, department_id: position.department.id,
                                                           user: manager_user)

    json_data = 'Cartão cadastrado com sucesso'
    fake_response = double('faraday_response', status: 201, body: json_data)
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/cards',
                                          { card: { company_card_type_id: position.card_type_id.to_s,
                                                    cpf: employee_profile.cpf } }.to_json,
                                          'Content-Type' => 'application/json')
                                    .and_return(fake_response)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response2 = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response2)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response2)

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)

    within('#department1') do
      click_on 'Ver departamento'
    end

    within('#employee\[1\]') do
      click_on 'Solicitar Cartão'
    end

    expect(current_path).to eq company_department_path(company_id: company.id, id: department.id)
    within('#employee\[1\]') do
      expect(page).not_to have_button('Solicitar Cartão')
    end
    expect(page).to have_content 'Cartão solicitado com sucesso'
    expect(fake_response.body).to eq 'Cartão cadastrado com sucesso'
  end

  scenario 'e api está indisponível' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "funcionario@#{company.domain}")
    manager_user = create(:manager_user, email: "funcionario@#{company.domain}")
    position = create(:position, department:)
    employee_profile = create(:employee_profile, position:, department_id: position.department.id,
                                                 status: 'unblocked', email: "funcionario@#{company.domain}",
                                                 cpf: '90900938005', user: manager_user)
    json_data = '{}'
    fake_response = double('faraday_response', status: 500, body: json_data)
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/cards',
                                          { card: { company_card_type_id: position.card_type_id.to_s,
                                                    cpf: employee_profile.cpf } }.to_json,
                                          'Content-Type' => 'application/json')
                                    .and_return(fake_response.status)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response2 = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response2)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response2)

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)

    within('#department1') do
      click_on 'Ver departamento'
    end

    within('#employee\[1\]') do
      click_on 'Solicitar Cartão'
    end

    expect(current_path).to eq company_department_path(company_id: company.id, id: department.id)
    within('#employee\[1\]') do
      expect(page).to have_button 'Solicitar Cartão'
    end
    expect(page).to have_content 'Sistema indisponível no momento, por favor tente mais tarde'
  end
  scenario 'e envia parâmetros errados' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:)
    manager_user = create(:manager_user)
    position = create(:position, department:)
    employee_profile = create(:employee_profile, :manager, position:, department_id: position.department.id,
                                                           user: manager_user)

    json_data = '{}'
    fake_response = double('faraday_response', status: 406, body: json_data)
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/cards',
                                          { card: { company_card_type_id: position.card_type_id.to_s,
                                                    cpf: employee_profile.cpf } }.to_json,
                                          'Content-Type' => 'application/json')
                                    .and_return(fake_response)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response2 = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response2)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response2)

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)

    within('#department1') do
      click_on 'Ver departamento'
    end

    within('#employee\[1\]') do
      click_on 'Solicitar Cartão'
    end

    expect(current_path).to eq company_department_path(company_id: company.id, id: department.id)
    within('#employee\[1\]') do
      expect(page).to have_button 'Solicitar Cartão'
    end
    expect(page).to have_content 'Cartão não solicitado, verifique informações'
  end
end
