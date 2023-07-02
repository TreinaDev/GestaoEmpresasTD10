require 'rails_helper'

feature 'Manager vê lista de departamentos' do
  scenario 'Com sucesso' do
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')
    department = create(:department, company:)
    position = create(:position, department:)
    create(:manager_emails, email: 'user@apple.com', company:)
    manager = create(:user, email: 'user@apple.com', cpf: '59684958471')
    create(:employee_profile, :manager, user: manager, department:, position:, email: "employee@#{company.domain}")
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
