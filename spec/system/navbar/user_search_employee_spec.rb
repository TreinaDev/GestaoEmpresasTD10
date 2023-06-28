require 'rails_helper'

feature 'Manager procura na barra de pesquisa' do
  scenario 'via cpf com sucesso' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, position:, department_id: position.department.id,
                                        user: manager)
    create(:employee_profile, :employee, cpf: '40690463804', department:)
    create(:employee_user, cpf: '40690463804')
    create(:employee_profile, :employee, cpf: '72859417940')

    login_as manager
    visit root_path
    fill_in 'Pesquisar', with: '40690463804'
    within('nav') do
      find('.search-button').click
    end

    expect(current_path).to eq search_companies_path
    expect(page).to have_content 'CPF'
    expect(page).to have_content '40690463804'
    expect(page).not_to have_content '72859417940'
  end

  scenario 'via nome e acha múltiplos resultados' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, position:, department_id: position.department.id,
                                        user: manager)
    create(:employee_profile, :employee, cpf: '40690463804', name: 'Jennifer Lopez', department:)
    create(:employee_user, cpf: '40690463804')
    create(:employee_profile, :employee, cpf: '21151751235', name: 'Jessica Alba',
                                         department:, status: 'blocked')
    create(:employee_user, cpf: '21151751235', email: 'jessica@microsoft.com')

    login_as manager
    visit root_path
    fill_in 'Pesquisar', with: 'Je'
    within('nav') do
      find('.search-button').click
    end

    expect(page).to have_content 'Nome'
    expect(page).to have_content 'Jennifer'
    expect(page).to have_content 'Jessica Alba'
    expect(page).to have_content 'Cargo'
    expect(page).to have_content 'Estagiário'
    expect(page).to have_content 'Departamento'
    expect(page).to have_content 'Departamento de RH'
    expect(page).to have_content 'Status'
    expect(page).to have_content 'Ativo'
    expect(page).to have_content 'Bloqueado'
  end

  scenario 'e não acha nada' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, position:, department_id: position.department.id,
                                        user: manager)

    login_as manager
    visit root_path
    fill_in 'Pesquisar', with: '*'
    within('nav') do
      find('.search-button').click
    end

    expect(page).to have_content 'Nenhum resultado encontrado'
  end
end

feature 'employee' do
  scenario 'não vê barra de navegação na sua navbar' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, position:, department_id: position.department.id,
                                        user: manager)
    create(:employee_profile, :employee, cpf: '40690463804', department:)
    employee_user = create(:employee_user, cpf: '40690463804')

    login_as employee_user
    visit root_path

    expect(page).not_to have_field 'Pesquisar'
  end
end
