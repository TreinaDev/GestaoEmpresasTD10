require 'rails_helper'

feature 'Admin atualiza status' do
  context 'para Ativo' do
    scenario 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999',
                            email: 'company@apple.com',
                            domain: 'apple.com', status: false)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      company.save!

      login_as admin
      visit company_path(company)
      click_on 'Ativar'

      expect(current_path).to eq company_path(company)
      expect(page).to have_content('Status: Ativo')
      expect(page).not_to have_content('Status: Inativo')
      expect(company.reload.status).to eq true
    end

    scenario 'e vê empresa na página de empresas' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999',
                            email: 'company@apple.com',
                            domain: 'apple.com', status: false)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')
      company.save!

      login_as admin
      visit company_path(company)
      click_on 'Ativar'
      visit companies_path

      expect(current_path).to eq companies_path
      expect(page).to have_content 'Apple'
      expect(page).to have_content 'apple.com'
      expect(page).to have_css('img[alt="Apple"]')
      expect(company.reload.status).to eq true
    end
  end

  context 'para Inativo' do
    scenario 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
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
      click_on 'Desativar'

      expect(current_path).to eq company_path(company)
      expect(page).to have_content('Status: Inativo')
      expect(page).not_to have_content('Status: Ativo')
      expect(company.reload.status).to eq false
    end

    scenario 'e vê empresa na página de empresas inativas' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
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
      click_on 'Desativar'
      visit companies_path

      expect(current_path).to eq companies_path
      expect(page).not_to have_content 'Apple'
      expect(page).not_to have_content 'apple.com'
      expect(page).not_to have_css('img[alt="Apple"]')
      expect(company.reload.status).to eq false
    end
  end
end
