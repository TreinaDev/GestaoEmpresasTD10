require 'rails_helper'

feature 'administrador entra no sistema' do
  scenario 'e vê os itens estilizados do navbar' do
    user = create(:user, email: 'admin@punti.com')
    link_empresas = nil
    link_empresas_inativas = nil
    link_cadastrar_empresa = nil
    button_to_sair = nil

    login_as(user)
    visit root_path
    within('nav') do
      link_empresas = find('a', exact_text: 'Empresas Ativas')
      link_empresas_inativas = find('a', exact_text: 'Empresas Inativas')
      link_cadastrar_empresa = find('a', exact_text: 'Cadastrar Empresa')
      button_to_sair = find('button', exact_text: 'Sair')
    end

    expect(link_empresas[:class]).to include('dropdown-item')
    expect(link_empresas_inativas[:class]).to include('dropdown-item')
    expect(link_cadastrar_empresa[:class]).to include('dropdown-item')
    expect(button_to_sair[:class]).to include('btn dropdown-item')
    expect(button_to_sair[:class]).to include('dropdown-item')
    expect(button_to_sair[:class]).to include('btn')
  end

  context 'e clica no botão' do
    scenario 'de empresas ativas' do
      admin = create(:user, email: 'admin@punti.com')

      login_as admin
      visit root_path
      within('nav') do
        find('a', exact_text: 'Empresas Ativas').click
      end

      expect(current_path).to eq root_path
    end

    scenario 'de empresas inativas' do
      admin = create(:user, email: 'admin@punti.com')

      login_as admin
      visit root_path
      within('nav') do
        find('a', exact_text: 'Empresas Inativas').click
      end

      expect(current_path).to eq inactives_companies_path
    end

    scenario 'de cadastrar empresas' do
      admin = create(:user, email: 'admin@punti.com')

      login_as admin
      visit root_path
      within('nav') do
        find('a', exact_text: 'Cadastrar Empresa').click
      end

      expect(current_path).to eq new_company_path
    end
  end
end
