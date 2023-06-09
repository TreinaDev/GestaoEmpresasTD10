require 'rails_helper'

feature 'Admin bloqueia manager' do
  scenario 'com sucesso' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, department_id: department.id, user_id: manager.id, position:)

    login_as admin
    visit root_path
    click_on 'Empresas Ativas'
    within('#company1') do
      click_on 'Ver Detalhes'
    end
    click_on 'Gerentes'
    find("#block_user_#{manager.id}").click

    expect(current_path).to eq manager_company_path(company)
    expect(page).to have_button 'Desbloquear Gerente'
    expect(manager.employee_profile.status).to eq 'blocked'
    expect(page).to have_content 'Usuário Bloqueado'
  end
end

context 'usuário já bloqueado' do
  scenario 'Usuário tenta logar em conta bloqueada e é impedido.' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, status: 'blocked', department_id: department.id, user_id: manager.id, position:)

    visit root_path
    fill_in 'E-mail', with: 'manager@microsoft.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end

    expect(page).to have_content 'Sua conta está suspensa.'
  end

  scenario 'e admin o desbloqueia' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, status: 'blocked', department_id: department.id, user_id: manager.id, position:)

    login_as admin
    visit root_path
    click_on 'Empresas Ativas'
    within('#company1') do
      click_on 'Ver Detalhes'
    end
    click_on 'Gerentes'
    find("#unblock_user_#{manager.id}").click

    expect(current_path).to eq manager_company_path(company)
    expect(page).to have_button 'Bloquear Gerente'
    expect(manager.employee_profile.status).to eq 'unblocked'
    expect(page).to have_content 'Usuário Desbloqueado'
  end

  scenario 'e admin tenta desbloquear e falha' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, status: 'blocked', department_id: department.id, user_id: manager.id, position:)
    allow_any_instance_of(User).to receive(:unblock!).and_return(false)

    login_as admin
    visit root_path
    click_on 'Empresas Ativas'
    within('#company1') do
      click_on 'Ver Detalhes'
    end
    click_on 'Gerentes'
    find("#unblock_user_#{manager.id}").click

    expect(page).to have_content 'Não foi possível desbloquear o usuário'
  end
end

context 'visitante tenta acessar' do
  scenario 'Usuário que não é admin tenta acessar lista de Gerentes Cadastrados' do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, :manager, department_id: department.id, user_id: manager.id, position:)

    login_as manager
    visit users_path

    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Usuário sem permissão para executar essa ação'
  end
end
