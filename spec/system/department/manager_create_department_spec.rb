require 'rails_helper'

feature 'Manager cria departamento' do
  scenario 'Com sucesso'  do
    FactoryBot.create(:manager, email: 'user@apple.com')
    new_user = FactoryBot.create(:user, email: 'user@apple.com', cpf: '59684958471')
    FactoryBot.create(:company, brand_name: 'Apple')

    login_as(new_user)
    visit new_department_path
    fill_in "Nome",	with: "Jurídico"
    fill_in "Descrição",	with: "O departamento jurídico"
    fill_in "Código",	with: "AA007"
    select 'Apple', from: 'Empresas'
    click_on 'Criar Departamento'

    expect(page).to have_content 'Departamento criado com sucesso!'
    expect(page).to have_content 'Jurídico'
    expect(page).to have_content 'AA007'
    expect(page).to have_content 'Apple'
  end
end