require 'rails_helper'

feature 'visitante se cadastra' do
  scenario 'e vê o formulário de novo usuário' do
    visit root_path
    click_on 'Cadastrar-se'

    expect(current_path).to eq new_user_registration_path
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Senha'
    expect(page).to have_button 'Criar conta'
  end

  scenario 'com sucesso' do
    visit root_path

    click_on 'Cadastrar-se'
    fill_in 'E-mail', with: 'walisson@punti.com'
    fill_in 'Senha', with: 'password'
    fill_in 'CPF', with: '44429533768'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    expect(page).to have_content 'walisson@punti.com'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(page).to have_content 'ADMIN'
    expect(current_path).to eq root_path
    expect(page).to_not have_button 'Cadastrar-se'
    expect(User.first.role).to eq 'admin'
  end

  scenario 'e tem role padrão' do
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)
    create(:employee, position:, department:, email: 'bruno@gmail.com', cpf: '44429533768')

    visit root_path

    click_on 'Cadastrar-se'
    fill_in 'E-mail', with: 'bruno@gmail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'CPF', with: '44429533768'
    fill_in 'Confirme sua senha',	with: 'password'
    click_on 'Criar conta'

    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(page).to have_content 'FUNCIONÁRIO'
    expect(User.first.role).to eq 'employee'
  end

  scenario 'e tem role de manager' do
    admin = create(:user, email: 'admin@punti.com')
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)
    create(:manager, company:, created_by: admin, email: 'bruno@gmail.com')
    create(:employee, position:, department:, email: 'bruno@gmail.com', cpf: '44429533768')

    visit root_path

    click_on 'Cadastrar-se'
    fill_in 'E-mail', with: 'bruno@gmail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'CPF', with: '44429533768'
    fill_in 'Confirme sua senha',	with: 'password'
    click_on 'Criar conta'

    expect(page).to have_content 'Você realizou seu registro com sucesso'
    # debugger
    expect(page).to have_content 'GERENTE'
    expect(User.find_by(cpf: '44429533768').role).to eq 'manager'
  end
end
