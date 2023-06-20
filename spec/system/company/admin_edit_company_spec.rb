require 'rails_helper'

feature 'Usuário edita empresa' do
  context 'enquanto Admin' do
    scenario 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = FactoryBot.create(:company, active: true)

      login_as admin
      visit company_path(company)
      click_on 'Editar'
      fill_in 'Nome fantasia', with: 'Maçã'
      fill_in 'Razão social', with: 'Jobs Apple ltda'
      fill_in 'CNPJ',	with: '12.654.678/0005-55'
      fill_in 'Endereço',	with: 'Rua vale do silício, 8000'
      fill_in 'Telefone', with: '11 98888-8888'
      fill_in 'E-mail', with: 'jobs@maca.com'
      fill_in 'Domínio', with: 'maca.com'
      click_on 'Salvar'

      expect(page).to have_content 'Empresa atualizada com sucesso'
      expect(page).to have_content 'Maçã'
      expect(page).to have_content 'Jobs Apple ltda'
      expect(page).to have_content '12.654.678/0005-55'
      expect(page).to have_content 'Rua vale do silício, 8000'
      expect(page).to have_content '11 98888-8888'
      expect(page).to have_content 'jobs@maca.com'
      expect(page).to have_content 'maca.com'
      expect(page).to have_selector("img[src$='logo.png']")
    end

    scenario 'e todos os campos são necessários' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = FactoryBot.create(:company, active: true)

      login_as admin
      visit edit_company_path(company)
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

  context 'enquanto gerente' do
    scenario 'não vê botão para rota de editar' do
      admin = User.create!(email: 'admin@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = FactoryBot.create(:company, active: true)
      ManagerEmails.create!(email: 'manager@campuscode.com.br', created_by: admin, company:)
      manager = User.create!(email: 'manager@campuscode.com.br', role: :manager, password: '123456', cpf: '51959723030')

      login_as manager
      visit edit_company_path(company)

      expect(page).not_to have_link 'Editar'
    end
  end

  context 'enquanto funcionário' do
    scenario 'não vê botão para rota de editar' do
      company = FactoryBot.create(:company)
      department = FactoryBot.create(:department, company:)
      position = FactoryBot.create(:position, department:)
      FactoryBot.create(:employee_profile, position:, department:, email: 'employee@apple.com', cpf: '02324252481')
      employee = User.create!(email: 'employee@apple.com', password: '123456', cpf: '02324252481')

      login_as employee
      visit edit_company_path(company)

      expect(page).not_to have_link 'Editar'
    end
  end
end
