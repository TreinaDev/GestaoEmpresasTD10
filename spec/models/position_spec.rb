require 'rails_helper'

RSpec.describe Position, type: :model do
  describe 'validações' do
    context 'presença' do
      it 'valid' do
        position = build(:position)

        expect(position).to be_valid
      end

      it 'name' do
        position = build(:position, name: nil)

        expect(position.valid?).to eq false
        expect(position.errors[:name]).to include 'não pode ficar em branco'
      end

      it 'description' do
        position = build(:position, description: nil)

        expect(position.valid?).to eq false
        expect(position.errors[:description]).to include 'não pode ficar em branco'
      end

      it 'card_type_id' do
        position = build(:position, card_type_id: nil)

        expect(position.valid?).to eq false
        expect(position.errors[:card_type_id]).to include 'não pode ficar em branco'
      end

      it 'code' do
        position = build(:position, code: nil)

        expect(position.valid?).to eq false
        expect(position.errors[:code]).to include 'não pode ficar em branco'
      end

      it 'department' do
        position = build(:position, department: nil)

        expect(position.valid?).to eq false
        expect(position.errors[:department]).to include 'é obrigatório(a)'
      end
    end

    it 'formato do código' do
      position = build(:position, code: 'ABC1234')

      expect(position.valid?).to eq false
      expect(position.errors[:code]).to include 'Formato: 3 letras maiúsculas seguidas por 3 números (ex.: XYZ567)'
    end
  end
end
