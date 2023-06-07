# TODO: Alterar a navegação após a criação dos menus e links

require 'rails_helper'

describe 'Admin' do
  it 'registra uma empresa' do
    ##
    admin = User.create!(email: 'manoel@punti.com', role: admin, password: '123456')

    ##
    login_as admin
    visit new_company_path

    fill_in 'Nome fantasia',	with: 'Campus Code'
    fill_in 'Razão social', with: 'Campus Code Treinamentos LTDA'
    fill_in 'CNPJ', with: '00.394.460/0058-87'
    fill_in 'Endereço', with: 'Rua da tecnologia, nº 1500'
    fill_in 'Telefone', with: '1130302525'
    fill_in 'E-mail', with: 'contato@campuscode.com.br'
    fill_in 'Domínio', with: 'campuscode.com.br'
    attach_file 'company[logo]', Rails.root.join('spec/support/images/logo.png')

    click_on 'Salvar'

    ##
    expect(page).to have_content 'Empresa cadastrada com sucesso'
    expect(page).to have_css("img[src*='logo.png']")
    expect(page).to have_content 'Campus Code Treinamentos LTDA'
    expect(page).to have_content 'Rua da tecnologia, nº 1500'
    expect(page).to have_content 'contato@campuscode.com.br'
    expect(page).to have_content '00.394.460/0058-87'
  end

  it 'erros ao registra uma empresa' do
    ##
    admin = User.create!(email: 'manoel@punti.com', role: admin, password: '123456')

    ##
    login_as admin
    visit new_company_path

    fill_in 'Nome fantasia',	with: ''
    fill_in 'Razão social', with: 'Campus Code Treinamentos LTDA'
    fill_in 'CNPJ', with: '00.394.460/0058-87'
    fill_in 'Endereço', with: 'Rua da tecnologia, nº 1500'
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: 'contato@campuscode.com.br'
    fill_in 'Domínio', with: 'campuscode.com.br'

    click_on 'Salvar'

    ##
    expect(page).to have_content 'Empresa não cadastrada'
  end

  it 'visualiza as mensagens de erro de atributos na criação de empresa' do
    ##
    admin = User.create!(email: 'manoel@punti.com', role: admin, password: '123456')

    ##
    login_as admin
    visit new_company_path

    fill_in 'Nome fantasia',	with: ''
    fill_in 'Razão social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Telefone', with: '1130302525'
    fill_in 'E-mail', with: ''
    fill_in 'Domínio', with: ''

    click_on 'Salvar'

    ##
    expect(page).to have_content 'Empresa não cadastrada'
    expect(page).to have_content 'Razão social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content '1130302525'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Domínio não pode ficar em branco'
    expect(page).to have_content 'Logo não pode ficar em branco'
  end
end
