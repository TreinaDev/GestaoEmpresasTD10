require 'rails_helper'

feature 'Manager vê um cargo específico' do
  scenario 'Com sucesso' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    create(:employee_profile, :manager, user: manager)
    department = create(:department, company:)
    create(:position, department_id: department.id)

    second_position = create(:position, department_id: department.id, name: 'Programador')

    login_as manager
    visit company_department_position_path(company, department, second_position)

    expect(page).to have_content 'Nome: Programador'
    expect(page).to have_content 'Descrição: Faz tudo'
    expect(page).to have_content 'Departamento: Departamento de RH'
    expect(page).to have_content 'Empresa: Campus Code'
    expect(page).to have_link 'Editar cargo'
    expect(page).to have_link 'Cadastrar funcionário'
    expect(page).to have_link 'Ver cargos'
  end

  scenario 'E vê também a lista de funcionários deste cargo' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    create(:employee_profile, :manager, user: manager)
    department = create(:department, company:)
    position = create(:position, department_id: department.id)
    second_position = create(:position, department_id: department.id, name: 'Programador')

    create(:employee_profile, :employee, user: manager, position: second_position, department:)
    create(:employee_profile, :employee, user: manager, position:, department:, name: 'joaozinho',
                                         cpf: '09602079029')

    login_as manager
    visit company_department_position_path(company, department, second_position)

    within('#employees') do
      expect(page).to have_content 'Roberto Carlos Nascimento'
      expect(page).to have_content 'employee@microsoft.com'
      expect(page).to have_content 'Programador'
      expect(page).not_to have_content 'joaozinho'
      expect(page).not_to have_content '09602079029'
    end
  end

  scenario 'E não há funcionários no cargo' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    create(:employee_profile, :manager, user: manager)
    department = create(:department, company:)
    position = create(:position, department_id: department.id)

    second_position = create(:position, department_id: department.id, name: 'Programador')
    create(:employee_profile, :employee, user: manager, position:, department:, name: 'joaozinho',
                                         cpf: '09602079029')

    login_as manager
    visit company_department_position_path(company, department, second_position)

    expect(page).to have_content 'Não há funcionários nesta posição até o momento.'
  end
end
