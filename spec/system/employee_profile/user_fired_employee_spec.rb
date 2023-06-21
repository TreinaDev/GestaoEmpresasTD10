require 'rails_helper'

feature 'Desligamento de funcionário' do
  context 'como gerente' do
    scenario 'com sucesso' do
      admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company)
      create(:manager_emails, email: 'manager@campuscode.com.br', created_by: admin, company:)
      manager = create(:user, email: 'manager@campuscode.com.br', cpf: '14101674027')
      department = create(:department, company:)
      position = create(:position, department_id: department.id)
      employee_profile = create(:employee_profile, name: 'Roberto Carlos Nascimento', marital_status: 1,
                                                   dismissal_date: nil, department:, position:)

      login_as manager
      visit company_department_employee_profile_path(company.id, department.id, employee_profile.id)

      click_on 'Desligar funcionário'

      fill_in 'Data de Demissão', with: '10/05/2023'
      click_on 'Salvar'

      expect(page).to have_content 'Data de Demissão: 10/05/2023'
      expect(EmployeeProfile.first.status).to eq 'fired'
    end
  end
end
