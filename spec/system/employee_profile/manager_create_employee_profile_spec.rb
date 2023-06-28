require 'rails_helper'

feature 'Usuário cadastra perfil de funcionário' do
  context 'enquanto gerente' do
    scenario 'com sucesso' do
      admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)
      create(:manager_emails, created_by: admin, company:)
      manager = create(:manager_user)
      department = create(:department, company:)
      position = create(:position, department_id: department.id)

      fake_response = double('faraday_response', status: 200, body: '{}')
      Rails.root.join('spec/support/json/card_types.json').read
      cnpj = company.registration_number.tr('^0-9', '')
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)
      allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

      json_data = Rails.root.join('spec/support/json/cards2.json').read
      fake_response = double('faraday_response', status: 200, body: json_data)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/cards/19650667040').and_return(fake_response)

      login_as manager
      visit new_company_department_employee_profile_path(company.id, department.id)
      fill_in 'Nome Completo', with: 'João da Silva'
      fill_in 'Nome Social', with: 'João'
      fill_in 'E-mail', with: 'joao@campuscode.com.br'
      fill_in 'Data de Nascimento', with: '01/01/1980'
      fill_in 'CPF', with: '19650667040'
      fill_in 'RG', with: '408493057'
      fill_in 'Telefone', with: '11 99999-9999'
      fill_in 'Endereço', with: 'Rua do Avesso, 50'
      select 'Casado', from: 'Estado Civil'
      fill_in 'Data de Admissão', with: '12/10/2020'
      select position.name, from: 'Cargo'
      click_on 'Salvar'

      expect(page).to have_content('Perfil de Funcionário cadastrado com sucesso')
      expect(page).to have_content('Nome Completo: João da Silva')
      expect(page).to have_content('Nome Social: João')
      expect(page).to have_content('E-mail: joao@campuscode.com.br')
      expect(page).to have_content('Data de Nascimento: 01/01/1980')
      expect(page).to have_content('CPF: 196.506.670-40')
      expect(page).to have_content('RG: 408493057')
      expect(page).to have_content('Telefone: 11 99999-9999')
      expect(page).to have_content('Endereço: Rua do Avesso, 50')
      expect(page).to have_content('Estado Civil: Casado(a)')
      expect(page).to have_content('Data de Admissão: 12/10/2020')
      expect(page).to have_content("Departamento: #{department.name}")
      expect(page).to have_content("Cargo: #{position.name}")
    end

    scenario 'sem sucesso' do
      admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)
      create(:manager_emails, created_by: admin, company:)
      manager = create(:manager_user)
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      create(:employee_profile, :manager, department:, position:, user: manager)

      login_as manager
      visit new_company_department_employee_profile_path(company.id, department.id)
      fill_in 'Nome Completo', with: ''
      fill_in 'Nome Social', with: ''
      fill_in 'E-mail', with: ''
      fill_in 'Data de Nascimento', with: ''
      fill_in 'CPF', with: ''
      fill_in 'RG', with: ''
      fill_in 'Telefone', with: ''
      fill_in 'Endereço', with: ''
      fill_in 'Data de Admissão', with: ''
      click_on 'Salvar'

      expect(page).to have_content('Perfil de Funcionário não cadastrado')
      expect(page).to have_content('Nome Completo não pode ficar em branco')
      expect(page).to have_content('E-mail não pode ficar em branco')
      expect(page).to have_content('Data de Nascimento não pode ficar em branco')
      expect(page).to have_content('CPF não pode ficar em branco')
      expect(page).to have_content('RG não pode ficar em branco')
      expect(page).to have_content('Telefone não pode ficar em branco')
      expect(page).to have_content('Endereço não pode ficar em branco')
      expect(page).to have_content('Data de Admissão não pode ficar em branco')
    end

    scenario 'e não vê cargo de gerente na lista' do
      admin = create(:admin_user)
      company = create(:company)
      create(:manager_emails, created_by: admin, company:)
      manager = create(:manager_user)
      department = create(:department, company:)
      create(:position, department_id: department.id, name: 'Gerente', code: 'GER000')
      create(:position, department_id: department.id, name: 'Vendas', code: 'VEN001')

      login_as manager
      visit new_company_department_employee_profile_path(company.id, department.id)

      expect(page).to have_no_selector('select#employee_profile_position_id option', text: 'Gerente')
    end
  end
end
