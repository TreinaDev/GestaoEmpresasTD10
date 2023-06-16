require 'rails_helper'

feature 'Manager cria departamento' do
  scenario 'Com sucesso' do
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')
    create(:manager, email: 'user@apple.com', company:)
    new_user = create(:user, email: 'user@apple.com', cpf: '59684958471')
    allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('COD123')

    login_as(new_user)
    visit new_department_path

    fill_in 'Nome',	with: 'Jurídico'
    fill_in 'Descrição',	with: 'O departamento jurídico'
    select 'Apple', from: 'Empresa'
    click_on 'Salvar'

    expect(page).to have_content 'Departamento criado com sucesso!'
    expect(page).to have_content 'Jurídico'
    expect(page).to have_content 'COD123'
    expect(page).to have_content 'Apple'
  end

  scenario 'Com dados incompletos' do
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')
    create(:manager, email: 'user@apple.com', company:)
    new_user = create(:user, email: 'user@apple.com', cpf: '59684958471')

    login_as(new_user)
    visit new_department_path

    fill_in 'Nome',	with: ''
    fill_in 'Descrição',	with: 'O departamento jurídico'
    click_on 'Salvar'

    expect(page).to have_content 'Departamento não pode ser criado!'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Empresa é obrigatório(a)'
  end
end

feature 'usuário tenta criar departamento' do
  scenario  'mas apenas managers tem permissão para isso' do
    admin = create(:user, email: 'user@punti.com')

    login_as(admin)
    visit new_department_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Usuário sem permissão para executar essa ação'
  end
end
