require 'rails_helper'

feature 'Gerente cria cargo com sucesso' do
  scenario 'Com sucesso' do
    company = FactoryBot.create(:company)
    department = FactoryBot.create(:department, company:)
    admin_user = FactoryBot.create(:admin_user)
    FactoryBot.create(:manager, created_by: admin_user)
    manager_user = FactoryBot.create(:manager_user)

    login_as(manager_user)
    visit new_position_path
    fill_in 'Nome', with: 'Estagiário'
    fill_in 'Descrição', with: 'Faz tudo'
    fill_in 'Código', with: 'EST001'
    fill_in 'Departamento', with: department.id
    # select 'Cartão Black', from: 'Tipos de cartão'
    click_on 'Salvar'

    expect(current_path).to eq position_path(id: Position.first.id)
    expect(page).to have_content 'Cargo cadastrado com sucesso'
    expect(page).to have_content 'Nome: Estagiário'
    expect(page).to have_content 'Descrição: Faz tudo'
    expect(page).to have_content 'Código: EST001'
    # expect(page).to have_content 'Tipo de cartão: Cartão Black'
  end
end
