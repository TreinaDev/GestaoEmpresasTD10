require 'rails_helper'

feature 'administrator registra email do gerente da empresa' do
  scenario 'e não há empresas cadastradas' do
    user = create(:user, email: 'admin@punti.com')

    login_as(user)
    visit root_path
    click_on 'Empresas'

    expect(page).to have_content 'Não há empresas cadastradas'
  end

  scenario 'e vê formulário para cadastro' do
    user = create(:user, email: 'user@punti.com')
    create(:company)
    login_as(user)

    visit root_path
    click_on 'Empresas'
    click_on 'Google'

    expect(page).to have_field 'Cadastrar email'
    expect(page).to have_button 'Cadastrar'
  end

  scenario 'com sucesso' do
    user = create(:user, email: 'admin@punti.com')
    company = create(:company)
    login_as(user)

    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    fill_in 'Cadastrar email', with: 'usuario123@gmail.com'
    click_on 'Cadastrar'

    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Email cadastrado com sucesso'
    expect(page).to have_content 'Google'
  end

  scenario 'e falha porque o email não é de um domínio válido' do
    user = create(:user, email: 'admin@punti.com')
    create(:company)
    login_as(user)

    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    fill_in 'Cadastrar email', with: 'usuario123@outlook.com'
    click_on 'Cadastrar'

    expect(page).not_to have_content 'Email cadastrado com sucesso'
    expect(page).to have_content 'Não foi possível cadastrar email'
    expect(page).to have_content 'domínio do email não pertence a empresa'
  end

  scenario 'e falha porque o email é inválido' do
    user = create(:user, email: 'admin@punti.com')
    create(:company)
    login_as(user)

    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    fill_in 'Cadastrar email', with: 'usuário@@gmail.com'
    click_on 'Cadastrar'

    expect(page).not_to have_content 'Email cadastrado com sucesso'
    expect(page).to have_content 'Não foi possível cadastrar email'
    expect(page).to have_content 'Email não é válido'
  end

  scenario 'e falha porque o email já existe' do
    user = create(:user, email: 'admin@punti.com')
    company = create(:company)
    create(:manager, created_by: user, company:, email: 'zezinho@gmail.com')

    login_as(user)
    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    fill_in 'Cadastrar email', with: 'zezinho@gmail.com'
    click_on 'Cadastrar'

    expect(page).to have_content 'Email já cadastrado'
    expect(page).not_to have_content 'Email cadastrado com sucesso'
  end

  scenario 'e reativa o email já cadastrado e desativado previamente' do
    user = create(:user, email: 'admin@punti.com')
    company = create(:company)
    create(:manager, company:, created_by: user, status: :canceled, email: 'zezinho@gmail.com')

    login_as(user)
    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    fill_in 'Cadastrar email', with: 'zezinho@gmail.com'
    click_on 'Cadastrar'

    expect(current_path).to eq company_path(company)
    expect(page).not_to have_content 'Email cadastrado com sucesso'
    expect(page).to have_content 'Email reativado'
  end

  scenario 'e cadastra no domínio de outra empresa' do
    admin = create(:user, email: 'admin@punti.com')
    create(:company, registration_number: '123')
    create(:company, brand_name: 'Outlook', corporate_name: 'Outlook LTDA', domain: 'outlook.com')

    login_as(admin)
    visit root_path
    click_on 'Empresas'
    click_on 'Outlook'
    fill_in 'Cadastrar email', with: 'zezinho@gmail.com'
    click_on 'Cadastrar'

    expect(page).to have_content 'Não foi possível cadastrar email'
    expect(page).to have_content 'domínio do email não pertence a empresa'
  end

  scenario 'e não esta logado como administrador' do
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)
    create(:employee, position:, department:, email: 'zezinho@gmail.com', cpf: '30805775072')

    admin = create(:user, email: 'admin@punti.com')
    create(:manager, created_by: admin, company:)
    user = create(:user, email: 'zezinho@gmail.com', cpf: '30805775072')

    login_as(user)
    visit company_path(company)

    expect(current_path).to eq company_path(company)
    expect(page).not_to have_field 'Cadastrar email'
    expect(page).not_to have_button 'Cadastrar'
  end

  scenario 'e falha por não estar logado' do
    company = create(:company)

    visit company_path(company)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end
end
