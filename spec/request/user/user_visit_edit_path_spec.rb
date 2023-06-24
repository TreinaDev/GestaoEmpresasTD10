require 'rails_helper'

describe 'Usuário altera informações de uma empresa', type: :request do
  context 'enquanto admin' do
    it 'com sucesso' do
      admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456', cpf: '02324252481')
      company = create(:company, active: true)

      login_as admin

      new_attributes = {
        brand_name: 'Novo nome fantasia',
        corporate_name: 'Nova razão social ',
        registration_number: '98.765.432/1000-85',
        address: 'Novo endereço',
        phone_number: '22 88888-8888',
        email: 'novoemail@company.com',
        domain: 'novodominio.com'
      }

      patch company_path(company), params: { company: new_attributes }

      company.reload

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to company_path(company)
      expect(company.brand_name).to eq(new_attributes[:brand_name])
      expect(company.corporate_name).to eq(new_attributes[:corporate_name])
      expect(company.registration_number).to eq(new_attributes[:registration_number])
      expect(company.address).to eq(new_attributes[:address])
      expect(company.phone_number).to eq(new_attributes[:phone_number])
      expect(company.email).to eq(new_attributes[:email])
      expect(company.domain).to eq(new_attributes[:domain])
    end
  end

  context 'sem sucesso' do
    it 'enquanto gerente' do
      company = create(:company)
      create(:manager, company:)
      manager = create(:manager_user)
      create(:employee_profile, :manager, user: manager)

      company.active = false
      company.save!

      login_as manager
      get edit_company_path(company)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
    end

    it 'enquanto funcionário' do
      company = create(:company)
      department = create(:department, company:)
      position = create(:position, department:)
      create(:employee_profile, position:, department:, email: 'employee@apple.com', cpf: '02324252481')
      employee = User.create!(email: 'employee@apple.com', password: '123456', cpf: '02324252481')

      login_as employee
      get edit_company_path(company)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Usuário sem permissão para executar essa ação')
    end
  end
end
