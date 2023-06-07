require 'rails_helper'

describe 'Admin' do
  it 'acessa rota de edição com sucesso' do
    admin = User.create!(email: 'manoel@punti.com', role: 1, password: '123456')
    company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA', registration_number: '12.345.678/0001-95',
                          address: 'Rua California, 3000', phone_number: '11 99999-9999', email: 'company@apple.com',
                          domain: 'apple.com', status: true)
    company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                        filename: 'logo.png', content_type: 'logo.png')
    company.save!

    login_as admin
    visit company_path(company)
    click_on 'Editar'

    expect(current_path).to eq edit_company_path(company)
    expect(page).to have_field('Nome fantasia', type: 'text')
    expect(page).to have_field('Razão social', type: 'text')
    expect(page).to have_field('CNPJ', type: 'text')
    expect(page).to have_field('Endereço', type: 'text')
    expect(page).to have_field('Telefone', type: 'text')
    expect(page).to have_field('E-mail', type: 'text')
    expect(page).to have_field('Domínio', type: 'text')
    expect(page).to have_field('Logo', type: 'file')
  end

  it 'edita empresa com sucesso' do
    admin = User.create!(email: 'manoel@punti.com', role: 1, password: '123456')
    company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                          registration_number: '12.345.678/0001-95',
                          address: 'Rua California, 3000', phone_number: '11 99999-9999',
                          email: 'company@apple.com',
                          domain: 'apple.com', status: true)
    company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                        filename: 'logo.png', content_type: 'logo.png')
    company.save!

    login_as admin
    visit company_path(company)
    click_on 'Editar'
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
    expect(page).to have_selector("img[src$='logo.png']")
  end

  it 'falha ao editar empresa, por conter campos em branco' do
    admin = User.create!(email: 'manoel@punti.com', role: 1, password: '123456')
    company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                          registration_number: '12.345.678/0001-95',
                          address: 'Rua California, 3000', phone_number: '11 99999-9999',
                          email: 'company@apple.com',
                          domain: 'apple.com', status: true)
    company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                        filename: 'logo.png', content_type: 'logo.png')
    company.save!

    login_as admin
    visit company_path(company)
    click_on 'Editar'
    fill_in 'Nome fantasia', with: ''
    fill_in 'Razão social', with: ''
    fill_in 'CNPJ',	with: ''
    fill_in 'Endereço',	with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Domínio', with: ''
    click_on 'Salvar'

    expect(current_path).to eq company_path(company.id)
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Domínio não pode ficar em branco'
  end
end
