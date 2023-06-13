require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validações' do
    context 'CPF' do
      it 'CPF deve ser obrigatório' do
        new_user = User.new(email: 'user@punti.com', password: 'password')

        expect(new_user.valid?).to be false
      end
    end
  end

  describe 'Triagem' do
    context 'email de manager está pré cadastrado' do
      it 'Usuário tem role Manager' do
        admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
        Manager.create!(email: 'user@apple.com', created_by: admin)
        new_user = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')

        expect(new_user.valid?).to be true
        expect(new_user.role).to eq 'manager'
      end
    end
  end

  describe '#description' do
    it 'exibe o role e e-mail do Admin' do
      admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')

      result = admin.description

      expect(result).to eq('ADMIN - user@punti.com')
      expect(result).not_to eq('GERENTE - user@punti.com')
      expect(result).not_to eq('FUNCIONÁRIO - user@punti.com')
    end

    it 'exibe o role e e-mail do Manager' do
      admin = User.create!(email: 'user@punti.com', cpf: '05823272294', password: 'password')
      Manager.create!(email: 'user@apple.com', created_by: admin)
      new_user = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')

      result = new_user.description

      expect(result).not_to eq('ADMIN - user@punti.com')
      expect(result).to eq('GERENTE - user@apple.com')
      expect(result).not_to eq('FUNCIONÁRIO - user@apple.com')
    end

    it 'exibe o role e e-mail do Employee' do
      company = FactoryBot.create(:company)
      department = FactoryBot.create(:department, company:)
      position = FactoryBot.create(:position, department:)
      FactoryBot.create(
        :employee,
        position:,
        department:,
        email: 'user@treinadev.com',
        cpf: '44429533768',
        status: 'unblocked'
      )

      new_user = User.create!(email: 'user@treinadev.com', cpf: '44429533768', password: 'password')

      result = new_user.description

      expect(result).not_to eq('ADMIN - user@punti.com')
      expect(result).not_to eq('GERENTE - user@apple.com')
      expect(result).to eq('FUNCIONÁRIO - user@treinadev.com')
    end
  end
end
