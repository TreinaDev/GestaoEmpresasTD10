require 'rails_helper'

feature 'Manager vê lista de departamentos' do
  scenario 'Com sucesso' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    create(:employee_profile, :manager, user: manager)
    create(:department, company:)
    create(:department, name: 'Cozinha', company:)
    create(:department, name: 'Jurídico', company:)

    login_as manager
    visit company_departments_path(company)

    expect(page).to have_content 'Jurídico'
    expect(page).to have_content 'Cozinha'
    expect(page).to have_content 'Departamento de RH'
    expect(page).to have_content 'Funcionários no departamento:'
    expect(page).to have_link 'Ver departamento'
  end
end
