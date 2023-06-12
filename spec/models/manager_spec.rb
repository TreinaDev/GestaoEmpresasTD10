require 'rails_helper'

RSpec.describe Manager, type: :model do
  context 'presença' do
    it 'Email deve estar presente' do
      user = FactoryBot.create(:user)
      company = FactoryBot.create(:company, domain: 'gmail.com')
      manager = FactoryBot.build(:manager, created_by: user, company:, email: nil)

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('não pode ficar em branco')
    end

    it 'Criado por deve estar presente' do
      FactoryBot.create(:user)
      company = FactoryBot.create(:company, domain: 'gmail.com')
      manager = FactoryBot.build(:manager, created_by: nil, company:, email: 'marizinha@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:created_by]).to include('é obrigatório(a)')
    end

    it 'Empresa deve estar presente' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:company, domain: 'gmail.com')
      manager = FactoryBot.build(:manager, created_by: user, company: nil, email: 'marizinha@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:company]).to include('é obrigatório(a)')
    end
  end

  context 'valido' do
    it 'Email deve pertencer ao domínio da empresa' do
      user = FactoryBot.create(:user)
      company = FactoryBot.create(:company, domain: 'gmail.com')
      manager = FactoryBot.build(:manager, created_by: user, company:, email: 'teste@outlook.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('domínio do email não pertence a empresa')
    end

    it 'Email deve ser válido' do
      user = FactoryBot.create(:user)
      company = FactoryBot.create(:company, domain: 'gmail.com')
      manager = FactoryBot.build(:manager, created_by: user, company:, email: '@@teste@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('não é válido')
    end

    it 'Email deve ser do domínio da empresa que ele foi criado' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:company, domain: 'gmail.com')
      company = FactoryBot.create(:company, domain: 'outlook.com')
      manager = FactoryBot.build(:manager, created_by: user, company:, email: 'marizinha@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('domínio do email não pertence a empresa')
    end

    it 'Email não pode ser pre-cadastrado duas vezes' do
      user = FactoryBot.create(:user, email: 'admin@punti.com')
      company = FactoryBot.create(:company, domain: 'gmail.com')
      FactoryBot.create(:manager, created_by: user, company:, email: 'marizinha@gmail.com')
      manager = FactoryBot.build(:manager, created_by: user, company:, email: 'marizinha@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('já cadastrado')
    end

    it 'Criador deve ser administrador' do
      user = FactoryBot.create(:user)
      company = FactoryBot.create(:company, domain: 'gmail.com')
      manager = FactoryBot.build(:manager, created_by: user, company:, email: 'marizinha@gmail.com')

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:created_by]).to include('deve ser administrador')
    end

    it 'Email já está em usuário ativo' do
      user = FactoryBot.create(:user, email: 'admin@punti.com')
      company = FactoryBot.create(:company, domain: 'gmail.com')
      manager = FactoryBot.create(:manager, created_by: user, company:, email: 'marizinha@gmail.com')
      FactoryBot.create(:user, email: 'marizinha@gmail.com', cpf: '95683693098')

      manager.status = :canceled

      result = manager.valid?
      expect(result).to eq(false)
      expect(manager.errors[:email]).to include('já cadastrado em um usuário')
    end
  end
end
