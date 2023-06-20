require 'rails_helper'

feature 'Gerente vai para index do departamento' do
  scenario 'e vê todos os funcionários do departamento' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    employee_profile = create(:employee_profile, position:, department_id: position.department.id, 
                              status: 'unblocked', email: "funcionario@#{company.domain}", cpf: '90900938005')
    user = create(:user, email: "funcionario@#{company.domain}", password: 'password', cpf: '90900938005')

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)
    click_on 'RH'
    
    expect(current_path).to eq company_department_path(company_id: company.id, id: department.id)
    expect(page).to have_content 'Nome: RH'
    expect(page).to have_content 'Funcionários: Roberto Carlos Nascimento'
    expect(page).to have_button 'Solicitar Cartão'
  end
end