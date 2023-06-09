require 'rails_helper'

feature 'Admin bloqueia manager' do
  scenario 'e vê o índice de managers' do
    admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
    Manager.create!(email: 'user@apple.com', created_by: admin)
    manager = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')
    company = Company.create!(brand_name: 'Apple')
    department = Department.create!(company_id: company.id, name: 'rh')
    position = Position.create!(department_id: department.id, name: 'gerente')
    Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
                     user_id: manager.id)

    login_as admin
    visit root_path
    click_on 'Gerentes Cadastrados'

    expect(current_path).to eq users_path
    expect(page).to have_content 'Email'
    expect(page).to have_content 'user@apple.com'
    expect(page).to have_button 'Bloquear Gerente'
  end

  scenario 'com sucesso' do
    admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
    Manager.create!(email: 'user@apple.com', created_by: admin)
    manager = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')
    company = Company.create!(brand_name: 'Apple')
    department = Department.create!(company_id: company.id, name: 'rh')
    position = Position.create!(department_id: department.id, name: 'gerente')
    Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
                     user_id: manager.id)

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
    admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
    Manager.create!(email: 'user@apple.com', created_by: admin)
    manager = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')
    company = Company.create!(brand_name: 'Apple')
    department = Department.create!(company_id: company.id, name: 'rh')
    position = Position.create!(department_id: department.id, name: 'gerente')
    Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
                     user_id: manager.id)
    allow_any_instance_of(User).to receive(:block!).and_return(false)

    login_as admin
    visit root_path
    click_on 'Gerentes Cadastrados'
    find("#block_user_#{manager.id}").click

    expect(page).to have_content 'Não foi possível bloquear o usuário'
  end

  scenario 'Usuário tenta logar em conta bloqueada e é impedido.' do
    admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
    Manager.create!(email: 'user@apple.com', created_by: admin)
    manager = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')
    company = Company.create!(brand_name: 'Apple')
    department = Department.create!(company_id: company.id, name: 'rh')
    position = Position.create!(department_id: department.id, name: 'gerente')
    Employee.create!(status: 'blocked', department_id: department.id, position_id: position.id,
                     user_id: manager.id)

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'user@apple.com'
    fill_in 'Senha', with: 'password'
    within('div#form') do
      click_on 'Entrar'
    end

    expect(page).to have_content 'Sua conta está suspensa.'
  end

  scenario 'e desbloqueia' do
    admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
    Manager.create!(email: 'user@apple.com', created_by: admin)
    manager = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')
    company = Company.create!(brand_name: 'Apple')
    department = Department.create!(company_id: company.id, name: 'rh')
    position = Position.create!(department_id: department.id, name: 'gerente')
    Employee.create!(status: 'blocked', department_id: department.id, position_id: position.id,
                     user_id: manager.id)

    login_as admin
    visit root_path
    click_on 'Gerentes Cadastrados'
    find("#unblock_user_#{manager.id}").click

    expect(current_path).to eq users_path
    expect(page).to have_button 'Bloquear Gerente'
    expect(manager.employee.status).to eq 'unblocked'
    expect(page).to have_content 'Usuário Desbloqueado'
  end

  scenario 'tenta desbloquear e falha' do
    admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
    Manager.create!(email: 'user@apple.com', created_by: admin)
    manager = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')
    company = Company.create!(brand_name: 'Apple')
    department = Department.create!(company_id: company.id, name: 'rh')
    position = Position.create!(department_id: department.id, name: 'gerente')
    Employee.create!(status: 'blocked', department_id: department.id, position_id: position.id,
                     user_id: manager.id)
    allow_any_instance_of(User).to receive(:unblock!).and_return(false)

    login_as admin
    visit root_path
    click_on 'Gerentes Cadastrados'
    find("#unblock_user_#{manager.id}").click

    expect(page).to have_content 'Não foi possível desbloquear o usuário'
  end

  scenario 'visitante tenta acessar lista de Gerentes Cadastrados' do
    admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
    Manager.create!(email: 'user@apple.com', created_by: admin)
    manager = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')
    company = Company.create!(brand_name: 'Apple')
    department = Department.create!(company_id: company.id, name: 'rh')
    position = Position.create!(department_id: department.id, name: 'gerente')
    Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
                     user_id: manager.id)

    visit users_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Permissão negada'
  end

  scenario 'Usuário que não é admin tenta acessar lista de Gerentes Cadastrados' do
    admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
    Manager.create!(email: 'user@apple.com', created_by: admin)
    manager = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')
    company = Company.create!(brand_name: 'Apple')
    department = Department.create!(company_id: company.id, name: 'rh')
    position = Position.create!(department_id: department.id, name: 'gerente')
    Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
                     user_id: manager.id)

    login_as manager
    visit users_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Permissão negada'
  end
end
