require 'rails_helper'

feature 'Registro de funcionário' do
  scenario 'com sucesso' do
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)
    employee = create(
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
    click_on 'Criar conta'

    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(User.last.role).to eq 'employee'
    employee.reload
    expect(employee.user_id).to eq User.last.id
  end

  scenario 'sem sucesso pois não tem CPF pré-cadastrado' do
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)
    create(
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
    click_on 'Criar conta'

    expect(page).to have_content 'Não foi possível cadastrar usuário'
    expect(page).to have_content 'Email ou CPF não estão cadastrados nas tabelas correspondentes'
  end
end
