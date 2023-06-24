require 'rails_helper'

feature 'Gerente cria cargo' do
  scenario 'Com sucesso' do
    admin_user = create(:admin_user)
    company = create(:company)
    department = create(:department, company:)
    create(:manager, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:, code: 'DIR001')
    create(:employee_profile, :manager, position:, department:, user: manager_user)

    json_data = '{}'
    fake_status = double('faraday_status', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_status)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as(manager_user)
    visit new_company_department_position_path(company_id: company.id, department_id: department.id)
    fill_in 'Nome', with: 'Estagiário'
    fill_in 'Descrição', with: 'Faz tudo'
    select 'Cartão Avançado', from: 'Tipo de cartão'
    click_on 'Salvar'

    expect(current_path).to eq company_department_position_path(company_id: company.id, department_id: department.id,
                                                                id: Position.last.id)
    expect(page).to have_content 'Cargo cadastrado com sucesso'
    expect(page).to have_content 'Nome: Estagiário'
    expect(page).to have_content 'Descrição: Faz tudo'
    expect(page).to have_content 'Tipo de cartão: Cartão Avançado'
  end

  context 'sem sucesso' do
    scenario 'por falta de atributo obrigatório' do
      company = create(:company)
      department = create(:department, company:)
      admin_user = create(:admin_user)
      create(:manager, created_by: admin_user, company:, email: "nome@#{company.domain}")
      manager_user = create(:manager_user, email: "nome@#{company.domain}")

      create(:employee_profile, :manager, department:, user: manager_user)

      json_data = '{}'
      fake_status = double('faraday_status', status: 200, body: json_data)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_status)

      json_data = Rails.root.join('spec/support/json/card_types.json').read
      fake_response = double('faraday_response', status: 200, body: json_data)
      cnpj = company.registration_number.tr('^0-9', '')
      allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

      login_as(manager_user)
      visit new_company_department_position_path(company_id: company.id, department_id: department.id)

      fill_in 'Nome', with: ''
      fill_in 'Descrição', with: ''
      select 'Cartão Intermediário', from: 'Tipo de cartão'
      click_on 'Salvar'

      expect(current_path).to eq company_department_positions_path(company_id: company.id, department_id: department.id)
      expect(page).to have_content 'Cargo não cadastrado'
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'Descrição não pode ficar em branco'

      expect(Position.count).to eq 1
    end

    scenario 'por api estar indisponível' do
      company = create(:company)
      department = create(:department, company:)
      admin_user = create(:admin_user)
      create(:manager, created_by: admin_user, company:, email: "nome@#{company.domain}")
      manager_user = create(:manager_user, email: "nome@#{company.domain}")
      create(:employee_profile, :manager, department:, user: manager_user)

      json_data = '{}'
      fake_status = double('faraday_status', status: 500, body: json_data)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_status)

      login_as(manager_user)
      visit new_company_department_position_path(company_id: company.id, department_id: department.id)

      expect(current_path).to eq root_path
      expect(page).to have_content 'Sistema indisponível no momento, por favor tente mais tarde'
      expect(Position.count).to eq 1
    end
  end
end
