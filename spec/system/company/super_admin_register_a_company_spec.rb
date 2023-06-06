require 'rails_helper'

describe 'Super_Admin' do
  it 'registra uma empresa' do
    ##
    super_admin = User.create!(email: 'manoel@punti.com', role: super_admin, password: '123456')

    ##
    login_as super_admin
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
    super_admin = User.create!(email: 'manoel@punti.com', role: super_admin, password: '123456')

    ##
    login_as super_admin
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
end
