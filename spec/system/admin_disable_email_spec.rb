require 'rails_helper'

feature 'administrador desativa email do gerente' do
  scenario 'com sucesso' do
    user = create(:admin_user, email: 'admin@punti.com')
    company = create(:company, domain: 'gmail.com')
    Manager.create!(email: 'zezinho@gmail.com', created_by: user, company:)
    Manager.create!(email: 'mariazinha@gmail.com', created_by: user, company:)

    login_as(user)
    visit root_path
    click_on 'Empresas'

    within('#company1') do
      click_on 'Ver Detalhes'
    end
    find('button#delete1').click

    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Email desativado com sucesso'
    expect(page).not_to have_content 'zezinho@gmail.com'
    expect(page).to have_content 'mariazinha@gmail.com'
  end

  scenario 'e não lista quando o email pre-cadastrado já foi usado' do
    user = create(:admin_user, email: 'admin@punti.com')
    company = create(:company, domain: 'gmail.com')
    Manager.create!(email: 'zezinho@gmail.com', created_by: user, company:)
    Manager.create!(email: 'mariazinha@gmail.com', created_by: user, company:)
    create(:user, email: 'mariazinha@gmail.com', cpf: '80431871000')

    login_as(user)
    visit root_path
    click_on 'Empresas'
    within('#company1') do
      click_on 'Ver Detalhes'
    end

    expect(page).not_to have_content 'mariazinha@gmail.com'
    expect(page).to have_content 'zezinho@gmail.com'
  end
end
