require 'rails_helper'

feature 'Registro de uma empresa' do
  context 'Logado como admin' do
    scenario 'com sucesso' do
      admin = create(:admin_user)

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

    scenario 'e cria automaticamente uma empresa e um departamento' do
      admin = create(:admin_user)

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
      expect(Department.last.name).to eq 'Departamento de RH'
      expect(Position.last.name).to eq 'Gerente'
    end
  end

  context 'Com erro de permissão' do
    scenario 'Logado como gerente' do
      admin = create(:user, email: 'user@punti.com')
      company = create(:company, domain: 'gmail.com')
      create(:manager_emails, created_by: admin, company:, email: 'joaozinho@gmail.com')
      manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
      department = create(:department, company:)
      position = create(:position, department:)
      create(:employee_profile, :manager, status: 'unblocked', department:, user: manager, position:,
                                          email: 'joaozinho@gmail.com')

      login_as manager
      visit new_company_path

      expect(current_path).to eq company_path(company)
      expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    end

    scenario 'Logado como funcionário' do
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
      visit new_company_path

      expect(current_path).to eq company_path(company)
      expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    end
  end
end
