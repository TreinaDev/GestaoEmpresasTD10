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
        company = Company.create!(brand_name: 'Apple', corporate_name: 'Google LTDA', registration_number: '123456789',
                                  address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                                  domain: 'apple.com', status: true)
        Manager.create!(email: 'user@apple.com', created_by: admin, company:)
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
      company = Company.create!(brand_name: 'Apple', corporate_name: 'Google LTDA', registration_number: '123456789',
                                address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                                domain: 'apple.com', status: true)
      Manager.create!(email: 'user@apple.com', created_by: admin, company:)
      new_user = User.create!(email: 'user@apple.com', cpf: '44429533768', password: 'password')

      result = new_user.description

      expect(result).not_to eq('ADMIN - user@punti.com')
      expect(result).to eq('GERENTE - user@apple.com')
      expect(result).not_to eq('FUNCIONÁRIO - user@apple.com')
    end

    it 'exibe o role e e-mail do Employee' do
      new_user = User.create!(email: 'user@treinadev.com', cpf: '44429533768', password: 'password')

      result = new_user.description

      expect(result).not_to eq('ADMIN - user@punti.com')
      expect(result).not_to eq('GERENTE - user@apple.com')
      expect(result).to eq('FUNCIONÁRIO - user@treinadev.com')
    end
  end
end
