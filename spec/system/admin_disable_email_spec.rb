require 'rails_helper'

feature 'administrador desativa email do gerente' do
  scenario 'com sucesso' do
    user = User.create!(email: 'admin@punti.com', cpf: '05823272294', password: 'password', role: 0)
    company = Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
                              address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                              domain: 'gmail.com', status: true)
    Manager.create!(email: 'zezinho@gmail.com', created_by: user, company:, status: :active)
    Manager.create!(email: 'mariazinha@gmail.com', created_by: user, company:, status: :active)
    # Act
    login_as(user)
    visit root_path
    click_on 'Empresas'
    click_on 'Google'
    find('button#delete1').click
    # Assert
    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Email desativado com sucesso'
    expect(page).not_to have_content 'zezinho@gmail.com'
    expect(page).to have_content 'mariazinha@gmail.com'
  end
end
