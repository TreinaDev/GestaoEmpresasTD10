require 'rails_helper'

feature 'Gerente cria cargo' do
  scenario 'Com sucesso' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager, created_by: admin_user)
    manager_user = create(:manager_user)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{company.registration_number}").and_return(fake_response)

    login_as(manager_user)
    visit new_company_department_position_path(company_id: company.id, department_id: department.id)
    fill_in 'Nome', with: 'Estagiário'
    fill_in 'Descrição', with: 'Faz tudo'
    fill_in 'Código', with: 'EST001'
    select 'Cartão Avançado', from: 'Tipo de cartão'
    click_on 'Salvar'

    expect(current_path).to eq company_department_position_path(company_id: company.id, department_id: department.id,
                                                                id: Position.first.id)
    expect(page).to have_content 'Cargo cadastrado com sucesso'
    expect(page).to have_content 'Nome: Estagiário'
    expect(page).to have_content 'Descrição: Faz tudo'
    expect(page).to have_content 'Código: EST001'
    expect(page).to have_content 'Tipo de cartão: Cartão Avançado'
  end

  scenario 'sem sucesso por falta de atributo obrigatório' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager, created_by: admin_user)
    manager_user = create(:manager_user)
    create(:position, name: 'Estagiário', description: 'Faz tudo', code: 'EST001', card_type_id: 1, department:)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{company.registration_number}").and_return(fake_response)

    login_as(manager_user)
    visit new_company_department_position_path(company_id: company.id, department_id: department.id)
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: 'Relacionamento com clientes'
    fill_in 'Código', with: 'VND001'
    select 'Cartão Intermediário', from: 'Tipo de cartão'
    click_on 'Salvar'

    expect(current_path).to eq company_department_positions_path(company_id: company.id, department_id: department.id)
    expect(page).to have_content 'Cargo não cadastrado'
    expect(Position.count).to eq 0
  end
end
