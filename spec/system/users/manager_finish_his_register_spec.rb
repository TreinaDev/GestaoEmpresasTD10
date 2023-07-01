require 'rails_helper'

feature 'Manager é redirecionado ao acessar a aplicação' do
  scenario 'após fazer o primeiro cadastro' do
    admin = create(:admin_user)
    company = create(:company, :with_department)
    create(:manager_emails, created_by: admin, company:)

    visit new_user_registration_path
    fill_in 'E-mail', with: 'manager@microsoft.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'CPF', with: '43601436132'
    click_on 'Criar conta'

    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(User.last.role).to eq 'manager'
    expect(current_path).to eq new_manager_company_department_employee_profiles_path(company_id: company.id,
                                                                                     department_id: 1)
  end

  scenario 'após fazer login, sem perfil' do
    admin = create(:admin_user)
    company = create(:company)
    department = create(:department, company:)
    create(:position, name: 'Gerente', department:)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)

    login_as manager
    visit root_path

    expect(current_path).to eq new_manager_company_department_employee_profiles_path(company_id: company.id,
                                                                                     department_id: 1)
  end

  scenario 'e vê o formulário com certas informações já preenchidas e apenas como leitura' do
    admin = create(:admin_user)
    company = create(:company, :with_department)
    create(:position, name: 'Gerente', department: Department.first)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user, cpf: '36666153090', email: 'manager@microsoft.com')

    login_as manager
    visit root_path
    cpf_field = page.find('#employee_profile_cpf')
    email_field = page.find('#employee_profile_email')

    expect(cpf_field.value).to eq '36666153090'
    expect(cpf_field['readonly']).to eq('readonly')
    expect(email_field.value).to eq 'manager@microsoft.com'
    expect(email_field['readonly']).to eq('readonly')
  end

  scenario 'e preenche o formulário' do
    admin = create(:admin_user)
    company = create(:company, :with_department)
    create(:position, name: 'Gerente', department: Department.first)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user, cpf: '36666153090', email: 'manager@microsoft.com')

    login_as manager
    visit users_path

    fill_in 'Nome Completo', with: 'João da Silva'
    fill_in 'Nome Social', with: 'João'
    fill_in 'Data de Nascimento', with: '01/01/1990'
    fill_in 'RG', with: '408493057'
    fill_in 'Telefone', with: '11999999999'
    fill_in 'Endereço', with: 'Rua do Avesso, 50'
    select 'Casado', from: 'Estado Civil'
    fill_in 'Data de Admissão', with: '12/10/2020'
    click_on 'Salvar'

    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Perfil de Gerente atualizado com sucesso'
  end

  scenario 'e falha em acessar outra rota sem ter completo o registro' do
    admin = create(:admin_user)
    company = create(:company, :with_department)
    create(:position, name: 'Gerente', department: Department.first)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    login_as manager

    visit root_path
    page.find('#navbar-logo').click

    expect(current_path).to eq new_manager_company_department_employee_profiles_path(company_id: company.id,
                                                                                     department_id: 1)
  end

  scenario 'e sai sem preencher o formulário, e quando volta ainda precisa preencher' do
    admin = create(:admin_user)
    company = create(:company, :with_department)
    create(:position, name: 'Gerente', department: Department.first)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user, cpf: '36666153090', email: 'manager@microsoft.com')

    login_as manager
    visit root_path

    click_on 'Sair'
    fill_in 'E-mail', with: 'manager@microsoft.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'

    expect(current_path).to eq new_manager_company_department_employee_profiles_path(company_id: company.id,
                                                                                     department_id: 1)
  end

  scenario 'e preenche o formulário com dados incompletos' do
    admin = create(:admin_user)
    company = create(:company, :with_department)
    create(:position, name: 'Gerente', department: Department.first)

    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)

    login_as manager
    visit users_path

    fill_in 'Nome Completo', with: ''
    fill_in 'Nome Social', with: 'João'
    fill_in 'Data de Nascimento', with: '01/01/1980'
    fill_in 'RG', with: ''
    fill_in 'Telefone', with: '11 99999-9999'
    fill_in 'Endereço', with: 'Rua do Avesso, 50'
    select 'Casado', from: 'Estado Civil'
    fill_in 'Data de Admissão', with: '12/10/2020'
    click_on 'Salvar'

    expect(current_path).to eq create_manager_company_department_employee_profiles_path(company_id: company.id,
                                                                                        department_id: 1)
    expect(page).to have_content 'Não foi possível atualizar perfil de Gerente'
  end
end
