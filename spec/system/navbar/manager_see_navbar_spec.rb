require 'rails_helper'

feature 'manager entra no sistema' do
  scenario 'e não vê os itens do administrador' do
    company = create(:company, domain: 'email.com')
    create(:manager, company:)
    user_manager = create(:user, cpf: '50081919000')

    login_as(user_manager)
    visit root_path

    within('nav') do
      expect(page).not_to have_link 'Empresas'
      expect(page).not_to have_link 'Empresas Inativas'
      expect(page).not_to have_link 'Cadastrar empresa'
      expect(page).not_to have_link 'Gerentes Cadastrados'
      expect(page).to have_button 'Sair'
    end
  end
end
