require 'rails_helper'

feature 'Usuário visualiza empresas inativas' do
  context 'enquanto admin' do
    scenario 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      FactoryBot.create(:company, brand_name: 'Apple', domain: 'apple.com', active: false)
      FactoryBot.create(:company, brand_name: 'Microsoft', domain: 'microsoft.com',
                                  registration_number: '12.345.678/003-95', active: false)
      FactoryBot.create(:company, brand_name: 'IBM', domain: 'ibm.com',
                                  registration_number: '12.345.678/0002-95', active: true)

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
      FactoryBot.create(:company, active: true)

      login_as admin
      visit root_path
      click_on 'Empresas Inativas'

      expect(page).not_to have_content 'Apple'
      expect(page).not_to have_content 'Nenhuma empresa cadastrada'
      expect(page).to have_content 'Nenhuma empresa inativa'
    end
  end
end
