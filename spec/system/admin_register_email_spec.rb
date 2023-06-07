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

  
end
