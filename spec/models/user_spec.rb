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
end
