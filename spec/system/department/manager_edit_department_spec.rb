require 'rails_helper'

feature 'Manager edita departamento' do
  scenario 'Com sucesso' do
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')
    create(:manager_emails, email: 'user@apple.com', company:)
    new_user = create(:user, email: 'user@apple.com', cpf: '59684958471')
    allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('AAA007')
    department = create(:department, company:)

    login_as new_user
    visit company_department_path(company.id, department.id)
    click_on 'Editar'

    fill_in 'Nome',	with: 'Jurídico'
    fill_in 'Descrição',	with: 'O departamento jurídico'
    click_on 'Salvar'

    expect(page).to have_content 'Departamento atualizado com sucesso!'
    expect(page).to have_content 'Jurídico'
    expect(page).to have_content 'AAA007'
    expect(page).to have_content 'Apple'
  end

  scenario 'com dados incompletos' do
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')
    create(:manager_emails, email: 'user@apple.com', company:)
    new_user = create(:user, email: 'user@apple.com', cpf: '59684958471')
    department = create(:department, company:)

    login_as new_user
    visit company_department_path(company.id, department.id)
    click_on 'Editar'

    fill_in 'Nome',	with: 'Jurídico'
    fill_in 'Descrição',	with: ''
    click_on 'Salvar'

    expect(page).not_to have_content 'Departamento atualizado com sucesso!'
    expect(page).to have_content 'Não foi possível atualizar departamento!'
  end
end
