require 'rails_helper'

describe 'administrator register company manager email' do
  it 'and see registration form' do
    user = User.create!(email: 'admin@gmail.com', password: 'password', role: 1)
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

  it 'successfully' do
    user = User.create!(email: 'admin@gmail.com', password: 'password', role: 1)
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

  it 'and fails' do
    user = User.create!(email: 'admin@gmail.com', password: 'password', role: 1)
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
end
