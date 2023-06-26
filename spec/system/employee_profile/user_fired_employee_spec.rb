require 'rails_helper'

feature 'Desligamento de funcionário' do
  context 'como gerente' do
    scenario 'com sucesso' do
      admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)
      create(:manager_emails, created_by: admin, company:)
      manager = create(:manager_user, cpf: '14101674027')
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, :manager, name: 'Roberto Carlos Nascimento', marital_status: 1,
                                                             dismissal_date: nil, department:, position:)
      date = 1.day.from_now

      login_as manager
      visit company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      click_on 'Desligar funcionário'

      fill_in 'Data de Demissão', with: date
      click_on 'Desligar'

      expect(page).to have_content "Data de Demissão: #{date.strftime('%d/%m/%Y')}"
      expect(EmployeeProfile.first.status).to eq 'fired'
    end

    scenario 'e falha devido a data' do
      admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)
      create(:manager_emails, created_by: admin, company:)
      manager = create(:manager_user, cpf: '14101674027')
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento', marital_status: 1,
                                                              dismissal_date: nil, department:, position:)
      date = 1.day.ago

      login_as manager
      visit company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      click_on 'Desligar funcionário'

      fill_in 'Data de Demissão', with: date
      click_on 'Desligar'

      expect(page).to have_content 'Erro ao tentar desligar funcionário'
      expect(EmployeeProfile.first.status).to eq 'unblocked'
    end

    scenario 'e falha pois funcionário ja esta desligado' do
      admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)

      create(:manager_emails, created_by: admin, company:)
      manager = create(:manager_user, cpf: '14101674027')
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento', marital_status: 1,
                                                              dismissal_date: 1.day.from_now, department:,
                                                              position:, status: 'fired')

      login_as manager
      visit company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      expect(page).not_to have_link 'Desligar funcionário'
      expect(EmployeeProfile.first.status).to eq 'fired'
    end
  end

  context 'como admin' do
    scenario 'sem sucesso' do
      admin = create(:admin_user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento', marital_status: 1,
                                                              dismissal_date: nil, department:, position:)

      login_as admin
      visit company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      expect(current_path).to eq root_path
      expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    end
  end

  context 'como funcionário' do
    scenario 'sem sucesso' do
      company = create(:company)
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, :employee, name: 'Roberto Carlos Nascimento', marital_status: 1,
                                                              dismissal_date: nil, department:, position:)
      user_employee = create(:employee_user, email: employee_profile.email, cpf: employee_profile.cpf)

      login_as user_employee
      visit company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      expect(current_path).to eq root_path
      expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    end
  end
end
