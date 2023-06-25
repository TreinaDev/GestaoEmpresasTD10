require 'rails_helper'

RSpec.describe EmployeeProfile, type: :model do
  describe '#valido?' do
    it 'inválido quando campos estão em branco' do
      employee_profile = EmployeeProfile.new

      expect(employee_profile).not_to be_valid
      expect(employee_profile.errors[:name]).to include('não pode ficar em branco')
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
      company = create(:company)
      department = create(:department, company_id: company.id)
      position = create(:position, department_id: department.id)
      create(:manager_emails, company:)
      manager = create(:manager_user, email: 'manager@microsoft.com')

      create(:employee_profile, cpf: '15703243017', email: 'manager@microsoft.com', department:, position:,
                                user: manager)
      employee_profile = build(:employee_profile, cpf: '15703243017', department_id: department.id,
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
