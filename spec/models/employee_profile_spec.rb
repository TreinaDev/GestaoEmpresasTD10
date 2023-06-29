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

    it 'inválido quando RG já está em uso' do
      company = create(:company)
      department = create(:department, company_id: company.id)
      position = create(:position, department_id: department.id)
      create(:manager_emails, company:)
      manager = create(:manager_user, email: 'manager@microsoft.com')
      create(:employee_profile, cpf: '36666153090', rg: '1570324301', email: 'manager@microsoft.com', department:,
                                position:, user: manager)
      employee_profile = build(:employee_profile, cpf: '26773396921', rg: '1570324301',
                                                  department_id: department.id, position_id: position.id)

      expect(employee_profile).not_to be_valid
      expect(employee_profile.errors[:rg]).to include('já está em uso')
    end

    it 'inválido quando nome é cadastrado com número e formado por uma única palavra' do
      employee = build(:employee_profile, name: 'R07er7o')

      expect(employee).not_to be_valid
      expect(employee.errors[:name]).to include('deve conter apenas letras e ter no mínimo duas palavras')
    end

    it 'inválido quando o domain do email é diferente do domain da company' do
      company = create(:company)
      department = create(:department, company:)
      employee = build(:employee_profile, email: 'roberto@apple.com', department:)

      expect(employee).not_to be_valid
      expect(employee.errors[:email]).to include('deve ser do mesmo domínio da empresa')
    end

    it 'inválido quando o telefone não tem 11 dígitos' do
      employee = build(:employee_profile, phone_number: '777')

      expect(employee).not_to be_valid
      expect(employee.errors[:phone_number]).to include('não possui o tamanho esperado (11 caracteres)')
    end

    it 'inválido quando o birth_date for menor que 18 anos atrás' do
      employee = build(:employee_profile, birth_date: 10.months.ago)

      expect(employee).not_to be_valid
      expect(employee.errors[:birth_date]).to include('deve ser no mínimo 18 anos atrás')
    end

    it 'inválido quando a diferença entre admission_date e birth_date for menor que 18 anos ' do
      employee = build(:employee_profile, birth_date: 15.years.ago, admission_date: Time.zone.today)

      expect(employee).not_to be_valid
      expect(employee.errors[:admission_date]).to include('deve ser no mínimo 18 anos depois da data de nascimento')
    end

    it 'inválido quando admission_date for uma data futura' do
      employee = build(:employee_profile, admission_date: 3.days.from_now)

      expect(employee).not_to be_valid
      expect(employee.errors[:admission_date]).to include('deve ser anterior ou igual à data atual')
    end

    it 'inválido quando dimissal_date estiver no passado' do
      employee = build(:employee_profile, dismissal_date: '10/10/2010')

      expect(employee).not_to be_valid
      expect(employee.errors[:dismissal_date]).to include("deve ser maior que #{Time.zone.today}")
    end
  end
end
