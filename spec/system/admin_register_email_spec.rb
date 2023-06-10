require 'rails_helper'

feature 'administrator registra email do gerente da empresa' do
  scenario 'e vê formulário para cadastro' do
    user = User.create!(email: 'admin@gmail.com', cpf: '05823272294', password: 'password', role: 1)
    Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
                    address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                    domain: 'gmail.com', status: true)
    login_as(user)
    # Act
    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    # Assert
    expect(page).to have_field 'Cadastrar email'
    expect(page).to have_button 'Cadastrar'
  end

  scenario 'com sucesso' do
    user = User.create!(email: 'admin@gmail.com', cpf: '05823272294', password: 'password', role: 1)
    company = Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
                              address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                              domain: 'gmail.com', status: true)
    login_as(user)
    # Act
    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    fill_in 'Cadastrar email', with: 'usuario123@gmail.com'
    click_on 'Cadastrar'
    # Assert
    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Email cadastrado com sucesso'
    expect(page).to have_content 'Google'
  end

  scenario 'e falha porque o email não é de um ddomínio válido' do
    user = User.create!(email: 'admin@gmail.com', cpf: '05823272294', password: 'password', role: 1)
    Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
                    address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                    domain: 'gmail.com', status: true)
    login_as(user)
    # Act
    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    fill_in 'Cadastrar email', with: 'usuario123@outlook.com'
    click_on 'Cadastrar'
    # Assert
    expect(page).not_to have_content 'Email cadastrado com sucesso'
    expect(page).to have_content 'Não foi possível cadastrar email'
    expect(page).to have_content 'domínio do email não pertence a empresa'
  end

  scenario 'e falha porque o email é inválido' do
    user = User.create!(email: 'admin@gmail.com', cpf: '05823272294', password: 'password', role: 1)
    Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
                    address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                    domain: 'gmail.com', status: true)
    login_as(user)
    # Act
    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    fill_in 'Cadastrar email', with: 'usuário@@gmail.com'
    click_on 'Cadastrar'
    # Assert
    expect(page).not_to have_content 'Email cadastrado com sucesso'
    expect(page).to have_content 'Não foi possível cadastrar email'
    expect(page).to have_content 'Email não é válido'
  end

  scenario 'e falha porque o email já existe' do
    user = User.create!(email: 'admin@gmail.com', cpf: '05823272294', password: 'password', role: 1)
    company = Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
                              address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                              domain: 'gmail.com', status: true)
    Manager.create!(email: 'zezinho@gmail.com', created_by: user, company:, status: :active)

    login_as(user)
    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    fill_in 'Cadastrar email', with: 'zezinho@gmail.com'
    click_on 'Cadastrar'

    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Email já cadastrado'
    expect(page).not_to have_content 'Email cadastrado com sucesso'
  end

  scenario 'e reativa o email já cadastrado e desativado previamente' do
    user = User.create!(email: 'admin@gmail.com', cpf: '05823272294', password: 'password', role: 1)
    company = Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
                              address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                              domain: 'gmail.com', status: true)
    Manager.create!(email: 'zezinho@gmail.com', created_by: user, company:, status: :canceled)

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

  # scenario 'e não esta logado como administrador' do
  #   admin = User.create!(email: 'admin@punti.com', cpf: '05823272294', password: 'password')
  #   company = Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
  # address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
  # domain: 'gmail.com', status: true)
  #   Manager.create!(email: 'zezinho@gmail.com', created_by: admin, company: company)
  #   user = User.create!(email: 'zezinho@gmail.com', cpf: '76482272070', password: 'password')

  #   login_as(user)
  #   visit root_path

  #   expect(current_path).to eq company_path(company)
  #   expect(page).not_to have_field 'Cadastrar email'
  #   expect(page).not_to have_button 'Cadastrar'
  # end

  scenario 'e cadastra no domínio de outra empresa' do
    admin = User.create!(email: 'admin@punti.com', cpf: '05823272294', password: 'password')
    Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
                    address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                    domain: 'gmail.com', status: true)
    Company.create!(brand_name: 'Outlook', corporate_name: 'Outlook LTDA', registration_number: '123456789',
                    address: 'Rua abigail, 13', phone_number: '90900755433', email: 'contato@outlook.com',
                    domain: 'outlook.com', status: true)

    login_as(admin)
    visit root_path
    click_on 'Empresas'
    click_on 'Outlook'
    fill_in 'Cadastrar email', with: 'zezinho@gmail.com'
    click_on 'Cadastrar'

    expect(page).to have_content 'Não foi possível cadastrar email'
    expect(page).to have_content 'domínio do email não pertence a empresa'
  end
end
