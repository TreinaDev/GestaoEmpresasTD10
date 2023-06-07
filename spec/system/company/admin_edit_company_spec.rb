require 'rails_helper'

describe 'Admin' do
  it 'acessa rota de edição com sucesso' do
    admin = User.create!(email: 'manoel@punti.com', role: admin, password: '123456')
    Company.create!(brand_name: 'Apple', corporate_name: 'Apple LTDA', registration_number: '12.345.678/0001-95',
                    address: 'Rua California, 3000', phone_number: '11 99999-9999', email: 'company@apple.com',
                    domain: 'apple.com', status: true)

    login_as admin
    visit edit_company_path(Company.last)

    expect(current_path).to eq edit_company_path(Company.last)
    expect(page).to have_field('Nome fantasia')
    expect(page).to have_field('Razão social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Telefone')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Domínio')
  end

  it 'edita empresa com sucesso' do
    admin = User.create!(email: 'manoel@punti.com', role: admin, password: '123456')
    company = Company.create!(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                              registration_number: '12.345.678/0001-95',
                              address: 'Rua California, 3000', phone_number: '11 99999-9999',
                              email: 'company@apple.com',
                              domain: 'apple.com', status: true)

    login_as admin
    visit edit_company_path(company.id)

    fill_in 'Razão social', with: 'Jobs Apple ltda'
    fill_in 'Endereço',	with: 'Rua vale do silício, 8000'
    fill_in 'E-mail', with: 'jobs@apple.com'

    click_on 'Salvar'

    expect(current_path).to eq company_path(company.id)
    expect(page).to have_content 'Empresa atualizada com sucesso'
    expect(page).to have_content 'Apple'
    expect(page).to have_content 'Jobs Apple ltda'
    expect(page).to have_content '12.345.678/0001-95'
    expect(page).to have_content 'Jobs Apple ltda'
    expect(page).to have_content '11 99999-9999'
    expect(page).to have_content 'jobs@apple.com'
    expect(page).to have_content 'apple.com'
  end
end
