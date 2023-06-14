require 'rails_helper'

feature 'Usuário atualiza status' do
  context 'enquanto admin' do
    scenario 'para ativo com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = FactoryBot.create(:company, active: false)

      login_as admin
      visit company_path(company)
      click_on 'Ativar'

      expect(current_path).to eq company_path(company)
      expect(page).to have_content('Status: Ativo')
      expect(page).not_to have_content('Status: Inativo')
      expect(company.reload.active).to eq true
    end

    scenario 'para inativo com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = FactoryBot.create(:company, active: true)

      login_as admin
      visit company_path(company)
      click_on 'Desativar'

      expect(current_path).to eq company_path(company)
      expect(page).to have_content('Status: Inativo')
      expect(page).not_to have_content('Status: Ativo')
      expect(company.reload.active).to eq false
    end
  end

  context 'enquanto gerente' do
    scenario 'sem sucesso por não ver botão de desativar' do
      admin = User.create!(email: 'admin@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      Manager.create!(email: 'manager@apple.com', created_by: admin)
      manager = User.create!(email: 'manager@apple.com', role: :manager, password: '123456', cpf: '51959723030')
      company = FactoryBot.create(:company, active: true)

      login_as manager
      visit company_path(company)

      expect(page).not_to have_link 'Desativar'
    end

    scenario 'sem sucesso por não ver botão de ativar' do
      admin = User.create!(email: 'admin@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      Manager.create!(email: 'manager@apple.com', created_by: admin)
      manager = User.create!(email: 'manager@apple.com', role: :manager, password: '123456', cpf: '51959723030')
      company = FactoryBot.create(:company, active: false)

      login_as manager
      visit company_path(company)

      expect(page).not_to have_link 'Ativar'
    end
  end
end
