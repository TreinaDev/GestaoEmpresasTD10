require 'rails_helper'

feature 'Manager acessa a aplicação' do
  scenario 'após fazer o primeiro cadastro' do
    admin = create(:admin_user)
    company = create(:company, :with_department)
    create(:manager, created_by: admin, company:)
    
    visit new_user_registration_path
    fill_in 'E-mail', with: 'manager@microsoft.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'CPF', with: '43601436132'
    click_on 'Criar conta'

    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(User.last.role).to eq 'manager'
    expect(current_path).to eq new_manager_company_department_employee_profiles_path(company_id: company.id, department_id: 1)
  end

  scenario 'após fazer login, sem perfil' do
    admin = create(:admin_user)
    company = create(:company, :with_department)
    create(:manager, created_by: admin, company:)
    manager = create(:manager_user)

    login_as manager

    visit root_path
    expect(current_path).to eq new_manager_company_department_employee_profiles_path(company_id: company.id, department_id: 1)
  end

  scenario 'e preenche o formulário' do
    admin = create(:admin_user)
    company = create(:company, :with_department)
    create(:position, name: 'Gerente', department: Department.first)

    create(:manager, created_by: admin, company:)
    manager = create(:manager_user)
    
    login_as manager
    visit root_path

    fill_in 'Nome Completo', with: 'João da Silva'
    fill_in 'Nome Social', with: 'João'
    fill_in 'Data de Nascimento', with: '01/01/1980'
    fill_in 'RG', with: '408493057'
    fill_in 'Telefone', with: '11 99999-9999'
    fill_in 'Endereço', with: 'Rua do Avesso, 50'
    select 'Casado', from: 'Estado Civil'
    fill_in 'Data de Admissão', with: '12/10/2020'
    click_on 'Salvar'

    expect(current_path).to eq root_path
    # expect o cpf ter zaz

  end
end






#id: dom_id(cat, 'edit') %>
#find("#edit_category_#{cat.id}").click