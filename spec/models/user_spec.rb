require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validações' do
    context 'CPF' do
      it 'CPF deve ser obrigatório' do
        new_user = build(:user, email: 'user@punti.com', password: 'password', cpf: nil)

        expect(new_user.valid?).to be false
      end

      it 'deve estar no formato correto' do
        create(:admin_user, cpf: '444.295.337-68')

        expect(User.last.cpf).to eq '44429533768'
      end
    end
  end

  describe 'Triagem' do
    context 'email de manager está pré cadastrado' do
      it 'Usuário tem role Manager' do
        admin = create(:admin_user)
        company = create(:company)
        create(:manager_emails, created_by: admin, company:)
        new_user = create(:manager_user, cpf: '44429533768')

        expect(new_user.valid?).to be true
        expect(new_user.role).to eq 'manager'
      end
    end
  end

  describe '#description' do
    it 'exibe o role e e-mail do Admin' do
      admin = create(:admin_user, email: 'user@punti.com')

      result = admin.description

      expect(result).to eq('ADMIN - user@punti.com')
      expect(result).not_to eq('GERENTE - user@punti.com')
      expect(result).not_to eq('FUNCIONÁRIO - user@punti.com')
    end

    it 'exibe o role e e-mail do Manager' do
      admin = create(:admin_user)
      company = create(:company, domain: 'campuscode.com.br')
      create(:manager_emails, email: 'joaozinho@campuscode.com.br', created_by: admin, company:)
      new_user = create(:manager_user, email: 'joaozinho@campuscode.com.br', cpf: '44429533768')

      result = new_user.description

      expect(result).not_to eq('ADMIN - user@punti.com')
      expect(result).to eq('GERENTE - joaozinho@campuscode.com.br')
      expect(result).not_to eq('FUNCIONÁRIO - joaozinho@campuscode.com.br')
    end

    it 'exibe o role e e-mail do Employee' do
      company = create(:company)
      department = create(:department, company:)
      position = create(:position, department:)
      create(:employee_profile, position:, department:, email: 'user@microsoft.com', cpf: '44429533768')
      new_user = User.create!(email: 'user@microsoft.com', cpf: '44429533768', password: 'password')

      result = new_user.description

      expect(result).not_to eq('ADMIN - user@punti.com')
      expect(result).not_to eq('GERENTE - user@apple.com')
      expect(result).to eq('FUNCIONÁRIO - Roberto Carlos')
    end
  end
end
