require 'rails_helper'

RSpec.describe EmployeeProfile, type: :model do
  describe '#valido?' do
    it 'inválido quando campos estão em branco' do
      employee_profile = EmployeeProfile.new

      expect(employee_profile).not_to be_valid
      expect(employee_profile.errors[:name]).to include('não pode ficar em branco')
      expect(employee_profile.errors[:social_name]).to include('não pode ficar em branco')
      expect(employee_profile.errors[:email]).to include('não pode ficar em branco')
      expect(employee_profile.errors[:birth_date]).to include('não pode ficar em branco')
      expect(employee_profile.errors[:cpf]).to include('não pode ficar em branco')
      expect(employee_profile.errors[:rg]).to include('não pode ficar em branco')
      expect(employee_profile.errors[:phone_number]).to include('não pode ficar em branco')
      expect(employee_profile.errors[:address]).to include('não pode ficar em branco')
      expect(employee_profile.errors[:marital_status]).to include('não pode ficar em branco')
      expect(employee_profile.errors[:admission_date]).to include('não pode ficar em branco')
      expect(employee_profile.errors[:department]).to include('é obrigatório(a)')
      expect(employee_profile.errors[:position]).to include('é obrigatório(a)')
    end

    it 'inválido quando CPF já está em uso' do
      user_admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
      company = create(:company, registration_number: '00.394.460/0058-55')
      create(:manager_emails, email: 'manager@campuscode.com.br', created_by: user_admin, company:)
      create(:user, email: 'manager@campuscode.com.br', cpf: '14101674027')
      department = create(:department, company_id: company.id)
      position = create(:position, department_id: department.id)
      create(:employee_profile, cpf: '69551387074', department_id: department.id, position_id: position.id)
      employee_profile = build(:employee_profile, cpf: '69551387074', department_id: department.id,
                                                  position_id: position.id)

      expect(employee_profile).not_to be_valid
      expect(employee_profile.errors[:cpf]).to include('já está em uso')
    end
  end

  describe 'dismissal_date' do
    it 'tem que ser uma data futura' do
      employee = build(:employee_profile, dismissal_date: '10/10/2010')

      expect(employee.valid?).to be false
      expect(employee.errors[:dismissal_date]).to include("deve ser maior que #{Time.zone.today}")
    end
  end
end
