require 'rails_helper'

feature 'Registro de funcionário' do
  scenario 'com sucesso' do
    company = FactoryBot.create(:company)
    department = FactoryBot.create(:department, company:)
    position = FactoryBot.create(:position, department:)
    employee = FactoryBot.create(
      :employee,
      position:,
      department:,
      email: 'funcionario@empresa.com',
      cpf: '69142235219'
    )

    visit new_user_registration_path
    fill_in 'E-mail', with: 'funcionario@empresa.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'CPF', with: '69142235219'
    click_on 'Sign up'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso'
    expect(User.last.role).to eq 'employee'
    employee.reload
    expect(employee.user_id).to eq User.last.id
  end

  scenario 'sem sucesso' do
    company = FactoryBot.create(:company)
    department = FactoryBot.create(:department, company:)
    position = FactoryBot.create(:position, department:)
    FactoryBot.create(
      :employee,
      position:,
      department:,
      email: 'funcionario@empresa.com',
      cpf: '69142235219'
    )

    visit new_user_registration_path
    fill_in 'E-mail', with: 'funcionario@empresa.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'CPF', with: '66614254901'
    click_on 'Sign up'

    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'Email ou CPF não estão cadastrados nas tabelas correspondentes'
  end
end
