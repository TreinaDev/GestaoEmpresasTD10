require 'rails_helper'

feature 'Manager edita departamento' do
  scenario 'Com sucesso' do
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')
    create(:manager, email: 'user@apple.com', company:)
    new_user = create(:user, email: 'user@apple.com', cpf: '59684958471')
    department = create(:department, company:)

    login_as new_user
    visit edit_department_path(department.id)

    fill_in 'Nome',	with: 'Jurídico'
    fill_in 'Descrição',	with: 'O departamento jurídico'
    fill_in 'Código',	with: 'AAA007'
    select 'Apple', from: 'Empresa'
    click_on 'Criar Departamento'

    expect(page).to have_content 'Departamento atualizado com sucesso!'
    expect(page).to have_content 'Jurídico'
    expect(page).to have_content 'AAA007'
    expect(page).to have_content 'Apple'
  end

  scenario 'com dados incompletos' do
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')
    create(:manager, email: 'user@apple.com', company:)
    new_user = create(:user, email: 'user@apple.com', cpf: '59684958471')
    department = create(:department, company:)

    login_as new_user
    visit edit_department_path(department.id)

    fill_in 'Nome',	with: 'Jurídico'
    fill_in 'Descrição',	with: ''
    fill_in 'Código',	with: 'AAA007'
    select 'Apple', from: 'Empresa'
    click_on 'Criar Departamento'

    expect(page).not_to have_content 'Departamento atualizado com sucesso!'
    expect(page).to have_content 'Não foi possível atualizar departamento!'
  end
end
