require 'rails_helper'

feature 'Manager cria departamento' do
  scenario 'Com sucesso' do
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')
    department = create(:department, company:)
    position = create(:position, department:)
    create(:manager_emails, email: 'user@apple.com', company:)
    new_user = create(:user, email: 'user@apple.com', cpf: '59684958471')
    create(:employee_profile, :manager, user: new_user, department:, position:, email: "employee@#{company.domain}")
    allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('COD123')

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)

    login_as(new_user)
    visit new_company_department_path(company.id)

    fill_in 'Nome',	with: 'Jurídico'
    fill_in 'Descrição',	with: 'O departamento jurídico'
    click_on 'Salvar'

    expect(page).to have_content 'Departamento criado com sucesso!'
    expect(page).to have_content 'Jurídico'
    expect(page).to have_content 'COD123'
    expect(page).to have_content 'Apple'
  end

  scenario 'Com dados incompletos' do
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')
    department = create(:department, company:)
    position = create(:position, department:)
    create(:manager_emails, email: 'user@apple.com', company:)
    manager = create(:user, email: 'user@apple.com', cpf: '59684958471')
    create(:employee_profile, :manager, user: manager, department:, position:, email: "employee@#{company.domain}")

    login_as(manager)
    visit new_company_department_path(company.id)

    fill_in 'Nome',	with: ''
    fill_in 'Descrição',	with: 'O departamento jurídico'
    click_on 'Salvar'

    expect(page).to have_content 'Departamento não pode ser criado!'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end

feature 'usuário tenta criar departamento' do
  scenario  'mas apenas managers tem permissão para isso' do
    admin = create(:user, email: 'user@punti.com')
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')

    login_as(admin)
    visit new_company_department_path(company.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Usuário sem permissão para executar essa ação'
  end
end
