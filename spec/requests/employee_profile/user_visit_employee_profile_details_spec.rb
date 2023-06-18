require 'rails_helper'

describe 'Usuário acessa página de cadastro de perfil de funcionários', type: :request do
  context 'enquanto gerente' do
    it 'com sucesso' do
      admin = create(:user, email: 'admin@punti.com')
      company = create(:company)
      create(:manager, email: 'manager@campuscode.com.br', created_by: admin, company:)
      user_manager = create(:user, email: 'manager@campuscode.com.br', cpf: '59812249087')
      department = create(:department, company:)
      create(:position, department_id: department.id)

      login_as user_manager
      get new_employee_profile_path

      expect(response).to have_http_status(:ok)
    end
  end

  context 'enquanto admin' do
    it 'sem sucesso' do
      admin = create(:user, email: 'manoel@punti.com')

      login_as admin
      get new_employee_profile_path
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Permissão Negada')
    end
  end

  context 'enquanto funcionário' do
    it 'sem sucesso' do
      company = create(:company, active: false)
      department = create(:department, company:)
      position = create(:position, department:)
      create(:employee_profile, position:, department:, cpf: '02324252481')
      employee = create(:user, cpf: '02324252481', email: 'employee@campuscode.com.br')

      login_as employee
      get new_employee_profile_path

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Permissão Negada')
    end
  end
end

describe 'Usuário cadastra perfil de funcionário', type: :request do
  context 'enquanto gerente' do
    it 'com sucesso' do
      admin = create(:user, email: 'admin@punti.com')
      company = create(:company)
      create(:manager, email: 'manager@campuscode.com.br', created_by: admin, company:)
      user_manager = create(:user, email: 'manager@campuscode.com.br', cpf: '59812249087')
      department = create(:department, company:)
      position = create(:position, department_id: department.id)

      login_as user_manager

      new_attributes = {
        name: 'Novo nome',
        social_name: 'Nova nome social ',
        cpf: '73741924016',
        rg: '12345678',
        address: 'Rua Apple, 1',
        phone_number: '22 88888-8888',
        email: 'novoemail@apple.com',
        birth_date: '01-01-1990',
        admission_date: '01-01-2020',
        marital_status: 'single',
        department_id: department.id,
        position_id: position.id
      }

      post employee_profiles_path, params: { employee_profile: new_attributes }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to employee_profile_path(EmployeeProfile.last.id)
      expect(EmployeeProfile.last.name).to eq(new_attributes[:name])
      expect(EmployeeProfile.last.social_name).to eq(new_attributes[:social_name])
      expect(EmployeeProfile.last.cpf).to eq(new_attributes[:cpf])
      expect(EmployeeProfile.last.rg).to eq(new_attributes[:rg])
      expect(EmployeeProfile.last.address).to eq(new_attributes[:address])
      expect(EmployeeProfile.last.phone_number).to eq(new_attributes[:phone_number])
      expect(EmployeeProfile.last.birth_date.strftime('%d-%m-%Y')).to eq(new_attributes[:birth_date])
      expect(EmployeeProfile.last.admission_date.strftime('%d-%m-%Y')).to eq(new_attributes[:admission_date])
      expect(EmployeeProfile.last.marital_status).to eq(new_attributes[:marital_status])
      expect(EmployeeProfile.last.department_id).to eq(new_attributes[:department_id])
      expect(EmployeeProfile.last.position_id).to eq(new_attributes[:position_id])
    end
  end

  context 'enquanto admin' do
    it 'sem sucesso' do
      admin = create(:user, email: 'manoel@punti.com')
      company = create(:company, active: false)
      department = create(:department, company:)
      position = create(:position, department:)

      login_as admin

      new_attributes = {
        name: 'Novo nome',
        social_name: 'Nova nome social ',
        cpf: '73741924016',
        rg: '12345678',
        address: 'Rua Apple, 1',
        phone_number: '22 88888-8888',
        email: 'novoemail@apple.com',
        birth_date: '01-01-1990',
        admission_date: '01-01-2020',
        marital_status: 'single',
        department_id: department.id,
        position_id: position.id
      }

      post employee_profiles_path, params: { employee_profile: new_attributes }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Permissão Negada')
    end
  end

  context 'enquanto funcionário' do
    it 'sem sucesso' do
      company = create(:company, active: false)
      department = create(:department, company:)
      position = create(:position, department:)
      create(:employee_profile, position:, department:, cpf: '02324252481')
      employee = create(:user, cpf: '02324252481', email: 'employee@campuscode.com.br')

      login_as employee

      new_attributes = {
        name: 'Novo nome',
        social_name: 'Nova nome social ',
        cpf: '73741924016',
        rg: '12345678',
        address: 'Rua Apple, 1',
        phone_number: '22 88888-8888',
        email: 'novoemail@apple.com',
        birth_date: '01-01-1990',
        admission_date: '01-01-2020',
        marital_status: 'single',
        department_id: department.id,
        position_id: position.id
      }

      post employee_profiles_path, params: { employee_profile: new_attributes }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Permissão Negada')
    end
  end
end
