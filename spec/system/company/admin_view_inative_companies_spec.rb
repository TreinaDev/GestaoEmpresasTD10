require 'rails_helper'

feature 'Usuário visualiza empresas inativas' do
  context 'enquanto admin' do
    scenario 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua California, 3000', phone_number: '11 99999-9999',
                            email: 'company@apple.com',
                            domain: 'apple.com', status: false)
      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')

      company2 = Company.new(brand_name: 'Microsoft', corporate_name: 'Microsoft Corporation',
                             registration_number: '12.345.678/0011-95',
                             address: 'Rua do Vale, 1000', phone_number: '11 99999-9999',
                             email: 'company@microsoft.com',
                             domain: 'microsoft.com', status: false)

      company2.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                           filename: 'logo.png', content_type: 'logo.png')

      company3 = Company.new(brand_name: 'IBM', corporate_name: 'IBM Corporation',
                             registration_number: '12.345.678/0021-95',
                             address: 'Rua do Silício, 6000', phone_number: '11 99999-9999',
                             email: 'company@ibm.com',
                             domain: 'ibm.com', status: true)

      company3.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                           filename: 'logo.png', content_type: 'logo.png')
      company.save!
      company2.save!
      company3.save!

      login_as admin
      visit root_path
      click_on 'Empresas Inativas'

      expect(current_path).to eq inactives_companies_path
      expect(page).to have_content 'Apple'
      expect(page).to have_content 'apple.com'
      expect(page).to have_css('img[alt="Apple"]')
      expect(page).to have_content 'Microsoft'
      expect(page).to have_content 'microsoft.com'
      expect(page).to have_css('img[alt="Microsoft"]')
      expect(page).not_to have_content 'IBM'
      expect(page).not_to have_content 'ibm.com'
      expect(page).not_to have_css('img[alt="IBM"]')
    end

    scenario 'e vê mensagem caso não haja nenhuma empresa ativa' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = Company.new(brand_name: 'IBM', corporate_name: 'IBM Corporation',
                            registration_number: '12.345.678/0001-95',
                            address: 'Rua do Silício, 6000', phone_number: '11 99999-9999',
                            email: 'company@ibm.com',
                            domain: 'ibm.com', status: true)

      company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                          filename: 'logo.png', content_type: 'logo.png')

      company.save!

      login_as admin
      visit root_path
      click_on 'Empresas Inativas'

      expect(page).not_to have_content 'Apple'
      expect(page).not_to have_content 'Nenhuma empresa cadastrada'
      expect(page).to have_content 'Nenhuma empresa inativa'
    end
  end
end
