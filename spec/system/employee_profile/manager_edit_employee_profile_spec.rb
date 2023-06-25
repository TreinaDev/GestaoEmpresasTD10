require 'rails_helper'

feature 'Usuário edita perfil de funcionário' do
  context 'enquanto gerente' do
    scenario 'com sucesso' do
      admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)
      create(:manager_emails, email: 'manager@campuscode.com.br', created_by: admin, company:)
      manager = create(:user, email: 'manager@campuscode.com.br', cpf: '14101674027')
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, name: 'Roberto Carlos Nascimento', marital_status: 1, department:,
                                                   position:)

      login_as manager
      visit edit_company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      fill_in 'Nome Completo', with: 'João da Silva'
      select 'Casado', from: 'Estado Civil'
      click_on 'Salvar'

      expect(page).to have_content('Perfil de Funcionário atualizado com sucesso')
      expect(page).to have_content('Nome Completo: João da Silva')
      expect(page).to have_content('Estado Civil: Casado(a)')
    end

    scenario 'sem sucesso' do
      admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)
      create(:manager_emails, email: 'manager@campuscode.com.br', created_by: admin, company:)
      manager = create(:user, email: 'manager@campuscode.com.br', role: 1, cpf: '14101674027')
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, name: 'Roberto Carlos Nascimento', marital_status: 1, department:,
                                                   position:)

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
      admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, name: 'Roberto Carlos Nascimento', marital_status: 1, department:,
                                                   position:)

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
      employee_profile = create(:employee_profile, name: 'Roberto Carlos Nascimento', marital_status: 1, department:,
                                                   position:)
      employee = create(:employee_user, cpf: employee_profile.cpf)

      login_as employee
      visit edit_company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      expect(page).to have_content('Usuário sem permissão para executar essa ação')
    end
  end
end
