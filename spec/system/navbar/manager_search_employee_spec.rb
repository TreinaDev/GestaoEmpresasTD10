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
    employee = create(:employee_profile, :employee, cpf: '40690463804', department:)
    employee_user = create(:employee_user, cpf: '40690463804')
    other_employee = create(:employee_profile, :employee, cpf: '72859417940')

    login_as manager
    visit root_path
    fill_in 'Pesquisar', with: '40690463804'
    within('nav') do
      find('.search-button').click
    end

    expect(current_path).to eq search_companies_path
    expect(page).to have_content '40690463804'
    expect(page).not_to have_content '72859417940'
  end
end
