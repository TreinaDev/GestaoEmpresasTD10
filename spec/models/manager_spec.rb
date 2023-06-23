require 'rails_helper'

RSpec.describe Manager, type: :model do
  context 'presença' do
    it 'Email deve estar presente' do
      user = create(:admin_user, email: 'admin@punti.com')
      company = create(:company)
      manager = build(:manager, created_by: user, company:, email: nil)

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('não pode ficar em branco')
    end

    it 'Criado por deve estar presente' do
      create(:admin_user, email: 'admin@punti.com')
      company = create(:company)
      manager = build(:manager, created_by: nil, company:, email: 'marizinha@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:created_by]).to include('é obrigatório(a)')
    end

    it 'Empresa deve estar presente' do
      user = create(:admin_user, email: 'admin@punti.com')
      create(:company)
      manager = build(:manager, created_by: user, company: nil, email: 'marizinha@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:company]).to include('é obrigatório(a)')
    end
  end

  context 'valido' do
    it 'Email deve pertencer ao domínio da empresa' do
      user = create(:admin_user, email: 'admin@punti.com')
      company = create(:company)
      manager = build(:manager, created_by: user, company:, email: 'teste@outlook.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('domínio do email não pertence a empresa')
    end

    it 'Email deve ser válido' do
      user = create(:admin_user, email: 'admin@punti.com')
      company = create(:company)
      manager = build(:manager, created_by: user, company:, email: '@@teste@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('não é válido')
    end

    it 'Email deve ser do domínio da empresa que ele foi criado' do
      user = create(:admin_user, email: 'admin@punti.com')
      create(:company, registration_number: '123')
      company = create(:company, domain: 'outlook.com')
      manager = build(:manager, created_by: user, company:, email: 'marizinha@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('domínio do email não pertence a empresa')
    end

    it 'Email não pode ser pre-cadastrado duas vezes' do
      user = create(:admin_user, email: 'admin@punti.com')
      company = create(:company)
      create(:manager, created_by: user, company:, email: 'employee@microsoft.com')
      manager = build(:manager, created_by: user, company:, email: 'employee@microsoft.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('já cadastrado')
    end

    it 'Criador deve ser administrador' do
      admin = create(:admin_user, email: 'admin@punti.com', cpf: '02850181080')
      company = create(:company)
      create(:manager, email: 'employee@microsoft.com', company:, created_by: admin)
      user = create(:manager_user, email: 'employee@microsoft.com')
      manager = build(:manager, created_by: user, company:, email: 'marizinha@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:created_by]).to include('deve ser administrador')
    end

    it 'Email já está em usuário ativo' do
      user = create(:admin_user, email: 'admin@punti.com')
      company = create(:company)
      manager = create(:manager, created_by: user, company:, email: 'employee@microsoft.com')
      create(:manager_user, email: 'employee@microsoft.com', cpf: '95683693098')

      manager.status = :canceled

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('já cadastrado em um usuário')
    end

    it 'Empresa deve estar ativa' do
      user = create(:user, email: 'admin@punti.com')
      company = create(:company, active: false)
      manager = build(:manager, created_by: user, company:, email: 'teste@outlook.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:company]).to include('não está ativa')
    end
  end
end
