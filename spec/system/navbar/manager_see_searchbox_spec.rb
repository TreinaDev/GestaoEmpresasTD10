require 'rails_helper'

feature 'manager vê searchbox' do
  scenario 'na navbar' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    employee = create(:employee_profile, :employee, cpf: '40690463804')
    employee = create(:employee_profile, :employee, cpf: '72859417940')

    login_as manager
    visit root_path
    fill_in 'Pesquisar', with: '40690463804'
    click_on 'Buscar'

    within('nav') do
      expect(page).to have_field('Pesquisar')
      expect(page).to have_button('Buscar')
    end
    expect(current_path).to eq search_path
    expect(page).to have_content '40690463804'
    expect(page).not_to have_content '72859417940'
  end
end