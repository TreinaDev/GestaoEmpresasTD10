require 'rails_helper'

describe 'Visitante navega pela app' do
  it 'e vê tela inicial' do
    admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')

    login_as admin
    visit root_path

    expect(page).to have_content 'Boas vindas'
  end
end
