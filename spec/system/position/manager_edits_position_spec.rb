require 'rails_helper'

feature 'Gerente edita cargo' do
  scenario 'Com sucesso' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    create(:position, name: 'Estagiário', description: 'Faz tudo', code: 'EST001', card_type_id: 1, department:)

    json_data = '{}'
    fake_status = double('faraday_status', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_status)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)
    login_as(manager_user)
    visit edit_company_department_position_path(company_id: company.id, department_id: department.id,
                                                id: Position.first.id)
    fill_in 'Nome', with: 'Vendedor'
    fill_in 'Descrição', with: 'Relacionamento com clientes'
    fill_in 'Código', with: 'VND001'
    select 'Cartão Intermediário', from: 'Tipo de cartão'
    click_on 'Salvar'

    expect(current_path).to eq company_department_position_path(company_id: company.id, department_id: department.id,
                                                                id: Position.first.id)
    expect(page).to have_content 'Cargo editado com sucesso'
    expect(page).to have_content 'Nome: Vendedor'
    expect(page).to have_content 'Descrição: Relacionamento com clientes'
    expect(page).to have_content 'Código: VND001'
    expect(page).to have_content 'Tipo de cartão: Cartão Intermediário'
  end

  scenario 'sem sucesso por falta de atributo obrigatório' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    create(:position, name: 'Estagiário', description: 'Faz tudo', code: 'EST001', card_type_id: 1, department:)

    json_data = '{}'
    fake_status = double('faraday_status', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_status)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as(manager_user)
    visit edit_company_department_position_path(company_id: company.id, department_id: department.id,
                                                id: Position.first.id)
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    select 'Cartão Intermediário', from: 'Tipo de cartão'
    click_on 'Salvar'

    expect(current_path).to eq company_department_position_path(company_id: company.id, department_id: department.id,
                                                                id: Position.first.id)
    expect(Position.first.name).to eq 'Estagiário'
    expect(Position.first.description).to eq 'Faz tudo'
    expect(Position.first.code).to eq 'EST001'
    expect(Position.first.card_type_id).to eq 1
    expect(page).to have_content 'Cargo não editado'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Código Formato: 3 letras maiúsculas seguidas por 3 números (ex.: XYZ567)'
  end

  scenario 'sem sucesso por api estar indisponível' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    create(:position, name: 'Estagiário', description: 'Faz tudo', code: 'EST001', card_type_id: 1, department:)

    json_data = '{}'
    fake_response = double('faraday_response', status: 500, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)

    login_as(manager_user)
    visit edit_company_department_position_path(company_id: company.id, department_id: department.id,
                                                id: Position.first.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Sistema indisponível no momento, por favor tente mais tarde'
  end
end
