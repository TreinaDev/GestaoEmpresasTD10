require 'rails_helper'

feature 'Usuário não acessa página de recarga de cartão' do
  scenario 'logado como admin' do
    admin = create(:admin_user)
    company = create(:company, domain: 'empresa1.com')

    login_as admin
    visit new_company_recharge_history_path(company_id: company.id)

    expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    expect(current_path).to eq root_path
  end

  scenario 'logado como funcionário' do
    company = create(:company, domain: 'empresa1.com')
    department = create(:department, company:)
    position = create(:position, department:)
    employee = create(
      :employee_profile,
      position:,
      department:,
      name: 'Func Um',
      social_name: 'Func Um',
      status: 'unblocked',
      email: 'funcionario1@empresa1.com',
      cpf: '15703243017',
      card_status: true
    )

    employee_user = create(:user, email: employee.email, cpf: employee.cpf)

    login_as employee_user
    visit new_company_recharge_history_path(company_id: company.id)

    expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    expect(current_path).to eq company_path(company)
  end

  scenario 'logado como manager de outra company' do
    company = create(:company, domain: 'empresa1.com')
    department = create(:department, company:)
    position = create(:position, department:)
    create(:manager_emails, company:, email: 'manager@empresa1.com')
    manager_user = create(:manager_user, email: 'manager@empresa1.com', cpf: '69142235219')
    create(
      :employee_profile,
      department:,
      position:,
      email: 'manager@empresa1.com',
      cpf: '69142235219',
      status: 'unblocked',
      user: manager_user,
      name: 'Nome Gerente',
      social_name: 'Nome Gerente',
      card_status: true
    )
    company2 = create(:company, email: 'contato@empresa2.com', domain: 'empresa2.com')

    login_as manager_user
    visit new_company_recharge_history_path(company_id: company2.id)

    expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    expect(current_path).to eq company_path(company)
  end
end
