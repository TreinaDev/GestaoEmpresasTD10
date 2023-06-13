require 'rails_helper'

feature 'Admin bloqueia manager' do
  scenario 'com sucesso' do
    admin = create(:user, email: 'user@punti.com')
    company = create(:company)
    create(:manager, created_by: admin, company:)
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee, status: 'unblocked', department_id: department.id, user_id: manager.id, position:)

    login_as admin
    visit root_path
    click_on 'Gerentes Cadastrados'
    find("#block_user_#{manager.id}").click

    expect(current_path).to eq users_path
    expect(page).to have_button 'Desbloquear Gerente'
    expect(manager.employee.status).to eq 'blocked'
    expect(page).to have_content 'Usuário Bloqueado'
  end

  scenario 'e falha' do
    admin = create(:user, email: 'user@punti.com')
    company = create(:company)
    create(:manager, created_by: admin, company:)
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee, status: 'unblocked', department_id: department.id, user_id: manager.id, position:)
    allow_any_instance_of(User).to receive(:block!).and_return(false)

    login_as admin
    visit root_path
    click_on 'Gerentes Cadastrados'
    find("#block_user_#{manager.id}").click

    expect(page).to have_content 'Não foi possível bloquear o usuário'
  end
end
context 'usuário já bloqueado' do
  scenario 'Usuário tenta logar em conta bloqueada e é impedido.' do
    admin = create(:user, email: 'user@punti.com')
    company = create(:company)
    create(:manager, created_by: admin, company:)
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee, status: 'blocked', department_id: department.id, user_id: manager.id, position:)

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
    company = create(:company)
    create(:manager, created_by: admin, company:)
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee, status: 'blocked', department_id: department.id, user_id: manager.id, position:)

    login_as admin
    visit root_path
    click_on 'Gerentes Cadastrados'
    find("#unblock_user_#{manager.id}").click

    expect(current_path).to eq users_path
    expect(page).to have_button 'Bloquear Gerente'
    expect(manager.employee.status).to eq 'unblocked'
    expect(page).to have_content 'Usuário Desbloqueado'
  end

  scenario 'e admin tenta desbloquear e falha' do
    admin = create(:user, email: 'user@punti.com')
    company = create(:company, brand_name: 'Apple', domain: 'apple.com')
    Manager.create!(email: 'user@apple.com', created_by: admin, company:)
    manager = create(:user, email: 'user@apple.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    Employee.create!(status: 'blocked', department_id: department.id, position_id: position.id,
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
    company = create(:company)
    create(:manager, created_by: admin, company:)
    manager = create(:user, email: 'joaozinho@gmail.com', cpf: '44429533768')
    department = create(:department, company_id: company.id)
    position = create(:position, department_id: department.id)
    create(:employee, status: 'unblocked', department_id: department.id, user_id: manager.id, position:)

    visit users_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Permissão negada'
  end

  scenario 'Usuário que não é admin tenta acessar lista de Gerentes Cadastrados' do
    admin = create(:user, email: 'user@punti.com')
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)
    create(:employee, position:, department:, email: 'zezinho@gmail.com', cpf: '30805775072')

    create(:manager, created_by: admin, company:)
    manager = create(:user, cpf: '30805775072')
    position = create(:position, department_id: department.id)
    create(:employee, status: 'unblocked', department_id: department.id, user_id: manager.id, position:)

    login_as manager
    visit users_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Permissão negada'
  end
end
