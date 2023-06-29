require 'rails_helper'

feature 'manager entra no sistema' do
  scenario 'e não vê os itens do administrador' do
    company = create(:company)
    create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")

    login_as(manager_user)
    visit root_path

    within('nav') do
      expect(page).not_to have_link 'Empresas'
      expect(page).not_to have_link 'Empresas Inativas'
      expect(page).not_to have_link 'Cadastrar empresa'
      expect(page).not_to have_link 'Gerentes Cadastrados'
      expect(page).to have_button 'Sair'
    end
  end

  scenario 'e vê os items de manager ' do
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    create(:employee_profile, :manager, department:, position:, user: manager_user)

    login_as(manager_user)
    visit root_path

    within('nav') do
      expect(page).to have_link "#{company.brand_name}"
      expect(page).to have_link 'Departamentos'
      expect(page).to have_link 'Cadastrar departamento'
      expect(page).to have_link 'Lista de departamentos'
      expect(page).to have_link 'Departamento de RH'
    end
  end
end
