require 'rails_helper'

feature 'Usuário visualiza empresas ativas' do
  context 'enquanto admin' do
    scenario 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      FactoryBot.create(:company, brand_name: 'Apple', domain: 'apple.com', active: true)
      FactoryBot.create(:company, brand_name: 'Microsoft', registration_number: '12.345.678/0002-95',
                                  domain: 'microsoft.com', active: true)
      FactoryBot.create(:company, brand_name: 'IBM', registration_number: '12.345.678/0003-95',
                                  domain: 'ibm.com', active: false)

      login_as admin
      visit root_path
      click_on 'Empresas'

      expect(current_path).to eq companies_path
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
      company = FactoryBot.create(:company, active: false)

      login_as admin
      visit root_path
      click_on 'Empresas'

      expect(page).not_to have_content company.brand_name
      expect(page).not_to have_content 'Nenhuma empresa cadastrada'
      expect(page).to have_content 'Nenhuma empresa ativa'
    end
  end

  context 'enquanto gerente' do
    scenario 'sem sucesso' do
      admin = User.create!(email: 'admin@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      Manager.create!(email: 'manager@apple.com', created_by: admin)
      manager = User.create!(email: 'manager@apple.com', role: :manager, password: '123456', cpf: '51959723030')
      FactoryBot.create(:company, active: true)

      login_as manager
      visit root_path

      expect(page).not_to have_link 'Empresas'
    end
  end

  context 'enquanto funcionário' do
    scenario 'sem sucesso' do
      company = FactoryBot.create(:company)
      department = FactoryBot.create(:department, company:)
      position = FactoryBot.create(:position, department:)
      employee_data = FactoryBot.create(:employee, position:, department:)
      employee_user = User.create!(
        email: employee_data.email,
        cpf: employee_data.cpf,
        password: '123456'
      )

      login_as employee_user
      visit root_path

      expect(page).not_to have_link 'Empresas'
    end
  end
end
