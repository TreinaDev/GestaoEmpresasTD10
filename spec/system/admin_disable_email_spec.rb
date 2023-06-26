require 'rails_helper'

feature 'administrador desativa email do gerente' do
  scenario 'com sucesso' do
    user = create(:admin_user, email: 'admin@punti.com')
    company = create(:company, domain: 'gmail.com')
    ManagerEmails.create!(email: 'zezinho@gmail.com', created_by: user, company:)
    ManagerEmails.create!(email: 'mariazinha@gmail.com', created_by: user, company:)

    login_as(user)
    visit root_path
    within('#collapsibleNavbar') do
      click_on 'Empresas Ativas'
    end
    within('#company1') do
      click_on 'Ver Detalhes'
    end
    click_on 'Gerentes'
    find('button#delete1').click

    expect(current_path).to eq manager_company_path(company)
    expect(page).to have_content 'Email desativado com sucesso'
    expect(page).not_to have_content 'zezinho@gmail.com'
    expect(page).to have_content 'mariazinha@gmail.com'
  end

  scenario 'e não lista quando o email pre-cadastrado já foi usado' do
    user = create(:admin_user, email: 'admin@punti.com')
    company = create(:company, domain: 'gmail.com')
    department = create(:department, company:)
    position = create(:position, department:)
    ManagerEmails.create!(email: 'zezinho@gmail.com', created_by: user, company:)
    ManagerEmails.create!(email: 'mariazinha@gmail.com', created_by: user, company:)
    manager = create(:user, email: 'mariazinha@gmail.com', cpf: '80431871000')
    create(:employee_profile, :manager, email: 'mariazinha@gmail.com', department:, position:,
                                        user: manager)

    login_as(user)
    visit root_path
    click_on 'Empresas Ativas'
    within('#company1') do
      click_on 'Ver Detalhes'
    end
    click_on 'Gerentes'
    within('#tabela') do
      expect(page).not_to have_content 'mariazinha@gmail.com'
    end
    expect(page).to have_content 'zezinho@gmail.com'
    expect(page).to have_content 'mariazinha@gmail.com'
  end
end
