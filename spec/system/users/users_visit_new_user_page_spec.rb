require 'rails_helper'

describe 'visittante se cadastra' do
  it 'e vê o formulário de novo usuário' do
    visit root_path
    click_on 'Cadastrar-se'

    expect(current_path).to eq new_user_registration_path
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Senha'
    expect(page).to have_button 'Criar conta'
  end

  it 'com sucesso' do
    visit root_path

    click_on 'Cadastrar-se'
    fill_in 'E-mail', with: 'walisson@punti.com'
    fill_in 'Senha', with: 'password'
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

  # it "e falha" do

  #   visit root_path

  #   click_on 'Cadastrar-se'
  #   fill_in 'E-mail', with: 'bruno@gmail.com'
  #   fill_in 'Senha', with: 'password'
  #   fill_in 'Confirme sua senha',	with: 'password'
  #   click_on 'Criar conta'

  #   expect(page).to have_content 'Não foi possível cadastrar o usuário'
  #   expect(page).not_to have_content 'Você realizou seu registro com sucesso'
  #   expect(page).not_to have_button 'Sair'
  #   expect(current_path).to eq new_user_registration_path
  # end
end
