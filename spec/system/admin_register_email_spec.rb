require 'rails_helper'

feature 'administrator register company manager email' do
  scenario 'and see registration form' do
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

  scenario 'successfully' do
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

  scenario 'and fails because the email is not from a valid domain' do
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
    expect(page).to have_content 'precisa ser do domínio de uma empresa'
  end

  scenario 'and fails because the email is invalid' do
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
end
