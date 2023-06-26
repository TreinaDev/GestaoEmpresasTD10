require 'rails_helper'

feature 'Usuário visualiza empresas ativas' do
  context 'enquanto admin' do
    scenario 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      create(:company, brand_name: 'Apple', domain: 'apple.com', active: true, corporate_name: 'Apple LTDA')
      create(:company, brand_name: 'Microsoft', registration_number: '12.345.678/0002-95', domain: 'microsoft.com',
                       active: true, corporate_name: 'Microsoft Corporation')
      create(:company, brand_name: 'IBM', corporate_name: 'IBM Corporation', registration_number: '12.345.678/0003-95',
                       domain: 'ibm.com', active: false)

      login_as admin
      visit root_path
      click_on 'Empresas Ativas'

      expect(current_path).to eq root_path
      expect(page).to have_content 'Apple'
      expect(page).to have_content 'Apple LTDA'
      expect(page).to have_css('img[alt="Apple"]')
      expect(page).to have_content 'Microsoft'
      expect(page).to have_content 'Microsoft Corporation'
      expect(page).to have_css('img[alt="Microsoft"]')
      expect(page).not_to have_content 'IBM'
      expect(page).not_to have_content 'IBM Corporation'
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
      create(:manager_emails)
      manager = create(:manager_user)
      create(:employee_profile, :manager, user: manager)

      login_as manager
      visit root_path

      expect(page).not_to have_link 'Empresas'
    end
  end

  context 'enquanto funcionário' do
    scenario 'sem sucesso' do
      company = create(:company)
      department = create(:department, company:)
      position = create(:position, department:)
      employee_data = create(:employee_profile, :employee, position:, department:)

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
