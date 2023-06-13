require 'rails_helper'

feature 'Registro de uma empresa' do
  context 'Logado como admin' do
    scenario 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', password: '123456', cpf: '19650667040')

      login_as admin
      visit new_company_path

      fill_in 'Nome fantasia',	with: 'Campus Code'
      fill_in 'Razão social', with: 'Campus Code Treinamentos LTDA'
      fill_in 'CNPJ', with: '00.394.460/0058-87'
      fill_in 'Endereço', with: 'Rua da tecnologia, nº 1500'
      fill_in 'Telefone', with: '1130302525'
      fill_in 'E-mail', with: 'contato@campuscode.com.br'
      fill_in 'Domínio', with: 'campuscode.com.br'
      attach_file 'company[logo]', Rails.root.join('spec/support/images/logo.png')
      click_on 'Salvar'

      expect(page).to have_content 'Empresa cadastrada com sucesso'
      expect(page).to have_css("img[src*='logo.png']")
      expect(page).to have_content 'Campus Code Treinamentos LTDA'
      expect(page).to have_content 'Rua da tecnologia, nº 1500'
      expect(page).to have_content 'contato@campuscode.com.br'
      expect(page).to have_content '00.394.460/0058-87'
    end

    scenario 'com falha devido a campos faltantes' do
      admin = User.create!(email: 'manoel@punti.com', password: '123456', cpf: '19650667040')

      login_as admin
      visit new_company_path

      fill_in 'Nome fantasia',	with: ''
      fill_in 'Razão social', with: ''
      fill_in 'CNPJ', with: ''
      fill_in 'Endereço', with: ''
      fill_in 'Telefone', with: '1130302525'
      fill_in 'E-mail', with: ''
      fill_in 'Domínio', with: ''
      click_on 'Salvar'

      expect(page).to have_content 'Empresa não cadastrada'
      expect(page).to have_content 'Razão social não pode ficar em branco'
      expect(page).to have_content 'CNPJ não pode ficar em branco'
      expect(page).to have_content 'Endereço não pode ficar em branco'
      expect(page).to have_field   'Telefone', with: '1130302525'
      expect(page).to have_content 'E-mail não pode ficar em branco'
      expect(page).to have_content 'Domínio não pode ficar em branco'
      expect(page).to have_content 'Logo não pode ficar em branco'
    end
  end

  context 'Com erro de permissão' do
    scenario 'Logado como gerente' do
      admin = User.create!(email: 'manoel@punti.com', password: '123456', cpf: '19650667040')
      Manager.create!(email: 'gerente@empresa.com', created_by: admin)
      manager = User.create!(email: 'gerente@empresa.com', password: '123456', cpf: '75676854006')

      login_as manager
      visit new_company_path

      expect(current_path).to eq root_path
      expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    end

    scenario 'Logado como funcionário' do
      company = FactoryBot.create(:company)
      department = FactoryBot.create(:department, company:)
      position = FactoryBot.create(:position, department:)
      employee_data = FactoryBot.create(:employee_profile, position:, department:)
      employee_user = User.create!(
        email: employee_data.email,
        cpf: employee_data.cpf,
        password: '123456'
      )

      login_as employee_user
      visit new_company_path

      expect(current_path).to eq root_path
      expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    end
  end
end
