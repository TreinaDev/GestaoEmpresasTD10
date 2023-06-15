require 'rails_helper'

feature 'Gerente edita cargo' do
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
    visit edit_company_department_position_path(company_id: company.id, department_id: department.id)
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
end
