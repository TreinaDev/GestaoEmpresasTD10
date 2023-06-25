require 'rails_helper'

feature 'Usuário atualiza status' do
  context 'enquanto admin' do
    scenario 'para ativo com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = create(:company, active: false)

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
      company = create(:company, active: true)

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
      create(:manager_emails)
      manager = create(:manager_user)
      create(:employee_profile, :manager, user: manager)
      company = create(:company)

      login_as manager
      visit company_path(company)

      expect(page).not_to have_link 'Desativar'
    end

    scenario 'sem sucesso por não ver botão de ativar' do
      create(:manager_emails)
      company = create(:company)
      manager = create(:manager_user)
      create(:employee_profile, :manager, user: manager)

      company.active = false
      company.save!

      login_as manager
      visit company_path(company)

      expect(page).not_to have_link 'Ativar'
    end
  end
end
