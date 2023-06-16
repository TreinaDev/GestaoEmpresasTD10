require 'rails_helper'

feature 'Admin bloqueia manager' do
  scenario 'com sucesso' do
    admin = create(:user, email: 'user@punti.com')
    company = create(:company, domain: 'gmail.com')
    create(:manager, created_by: admin, company:, email: 'joaozinho@gmail.com')
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, status: 'unblocked', department_id: department.id, user_id: manager.id, position:)

    login_as admin
    visit root_path
    click_on 'Gerentes Cadastrados'
    find("#block_user_#{manager.id}").click

    expect(current_path).to eq users_path
    expect(page).to have_button 'Desbloquear Gerente'
    expect(manager.employee_profile.status).to eq 'blocked'
    expect(page).to have_content 'Usuário Bloqueado'
  end
end
context 'usuário já bloqueado' do
  scenario 'Usuário tenta logar em conta bloqueada e é impedido.' do
    admin = create(:user, email: 'user@punti.com')
    company = create(:company, domain: 'gmail.com')
    create(:manager, created_by: admin, company:, email: 'joaozinho@gmail.com')
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, status: 'blocked', department_id: department.id, user_id: manager.id, position:)

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'joaozinho@gmail.com'
    fill_in 'Senha', with: 'password'
    within('#form') do
      click_on 'Entrar'
    end

    expect(page).to have_content 'Sua conta está suspensa.'
  end

  scenario 'e admin o desbloqueia' do
    admin = create(:user, email: 'user@punti.com')
    company = create(:company, domain: 'gmail.com')
    create(:manager, created_by: admin, company:, email: 'joaozinho@gmail.com')
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, status: 'blocked', department_id: department.id, user_id: manager.id, position:)

    login_as admin
    visit root_path
    click_on 'Gerentes Cadastrados'
    find("#unblock_user_#{manager.id}").click

    expect(current_path).to eq users_path
    expect(page).to have_button 'Bloquear Gerente'
    expect(manager.employee_profile.status).to eq 'unblocked'
    expect(page).to have_content 'Usuário Desbloqueado'
  end

  scenario 'e admin tenta desbloquear e falha' do
    admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
    company = create(:company, email: 'contato@gmail.com', domain: 'gmail.com')
    create(:manager, created_by: admin, company:, email: 'joaozinho@gmail.com')
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    EmployeeProfile.create!(status: 'blocked', department_id: department.id, position_id: position.id,
                            user_id: manager.id)
    allow_any_instance_of(User).to receive(:unblock!).and_return(false)

    login_as admin
    visit root_path
    click_on 'Gerentes Cadastrados'
    find("#unblock_user_#{manager.id}").click

    expect(page).to have_content 'Não foi possível desbloquear o usuário'
  end
end

context 'visitante tenta acessar' do
  scenario 'lista de Gerentes Cadastrados' do
    admin = create(:user, email: 'user@punti.com')
    company = create(:company, domain: 'gmail.com')
    create(:manager, created_by: admin, company:, email: 'joaozinho@gmail.com')
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, status: 'unblocked', department_id: department.id, user_id: manager.id, position:)

    visit users_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Permissão negada'
  end

  scenario 'Usuário que não é admin tenta acessar lista de Gerentes Cadastrados' do
    admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
    company = create(:company, email: 'contato@gmail.com', domain: 'gmail.com')

    create(:manager, created_by: admin, company:, email: 'joaozinho@gmail.com')
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee_profile, status: 'unblocked', department_id: department.id, user_id: manager.id, position:)

    login_as manager
    visit users_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Permissão negada'
  end
end
