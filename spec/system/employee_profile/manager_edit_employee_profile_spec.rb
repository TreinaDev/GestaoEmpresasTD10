require 'rails_helper'

feature 'Usuário edita perfil de funcionário' do
  context 'enquanto gerente' do
    scenario 'com sucesso' do
      admin = create(:admin_user)
      company = create(:company)
      create(:manager_emails, created_by: admin, company:)
      manager = create(:manager_user)
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento',
                                                              marital_status: 1, department:, position:)

      json_data = Rails.root.join('spec/support/json/cards2.json').read
      fake_response = double('faraday_response', status: 200, body: json_data)
      allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/cards/#{employee_profile.cpf}").and_return(fake_response)

      json_data = Rails.root.join('spec/support/json/card_types.json').read
      fake_response = double('faraday_response', status: 200, body: json_data)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)

      json_data = Rails.root.join('spec/support/json/cards2.json').read
      fake_response = double('faraday_response', status: 200, body: json_data)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/cards/88316175088').and_return(fake_response)

      json_data = Rails.root.join('spec/support/json/card_types.json').read
      fake_response = double('faraday_response', status: 200, body: json_data)
      cnpj = company.registration_number.tr('^0-9', '')
      allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

      login_as manager
      visit edit_company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      fill_in 'Nome Completo', with: 'João da Silva'
      fill_in 'Nome Social', with: 'Jojo'
      fill_in 'CPF', with: '88316175088'
      fill_in 'RG', with: '444903574'
      fill_in 'Endereço', with: 'Rua guanabara, 51'
      fill_in 'Telefone', with: '81982343354'
      fill_in 'Data de Nascimento', with: '20/05/2000'
      select 'Casado', from: 'Estado Civil'
      click_on 'Salvar'

      expect(page).to have_content('Perfil de Funcionário atualizado com sucesso')
      expect(page).to have_content('Nome Completo: João da Silva')
      expect(page).to have_content('Nome Social: Jojo')
      expect(page).to have_content('CPF: 883.161.750-88')
      expect(page).to have_content('RG: 444903574')
      expect(page).to have_content('Endereço: Rua guanabara, 51')
      expect(page).to have_content('Telefone: 819823433')
      expect(page).to have_content('Data de Nascimento: 20/05/2000')
      expect(page).to have_content('Estado Civil: Casado(a)')
    end

    scenario 'sem sucesso' do
      admin = create(:admin_user)
      company = create(:company)
      create(:manager_emails, created_by: admin, company:)
      manager = create(:manager_user)
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento',
                                                              marital_status: 1, department:, position:)

      json_data = Rails.root.join('spec/support/json/cards2.json').read
      fake_response = double('faraday_response', status: 200, body: json_data)
      allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/cards/#{employee_profile.cpf}").and_return(fake_response)

      json_data = Rails.root.join('spec/support/json/card_types.json').read
      fake_response = double('faraday_response', status: 200, body: json_data)
      company.registration_number.tr('^0-9', '')
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)

      login_as manager
      visit edit_company_department_employee_profile_path(company.id, department.id, employee_profile.id)
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

      expect(page).to have_content('Perfil de Funcionário não atualizado')
      expect(page).to have_content('Nome Completo não pode ficar em branco')
      expect(page).to have_content('E-mail não pode ficar em branco')
      expect(page).to have_content('Data de Nascimento não pode ficar em branco')
      expect(page).to have_content('CPF não pode ficar em branco')
      expect(page).to have_content('RG não pode ficar em branco')
      expect(page).to have_content('Telefone não pode ficar em branco')
      expect(page).to have_content('Endereço não pode ficar em branco')
      expect(page).to have_content('Data de Admissão não pode ficar em branco')
    end
  end
  context 'enquanto admin' do
    scenario 'não altera dados do funcionario' do
      admin = create(:admin_user)
      company = create(:company)
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento',
                                                              marital_status: 1, department:, position:)

      login_as admin
      visit edit_company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      expect(page).to have_content('Usuário sem permissão para executar essa ação')
    end
  end
  context 'enquanto funcionario' do
    scenario 'não altera dados do funcionario' do
      create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento',
                                                              marital_status: 1, department:, position:)
      employee = create(:employee_user, :employee, cpf: employee_profile.cpf)

      login_as employee
      visit edit_company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      expect(page).to have_content('Usuário sem permissão para executar essa ação')
    end
  end
end
