require 'rails_helper'

RSpec.describe Position, type: :model do
  describe 'validações' do
    context 'presença' do
      it 'valid' do
        position = build(:position)

        expect(position).to be_valid
      end

      it 'invalid' do
        position = build(:position, name: '', description: '', card_type_id: '', code: '', department: nil)

        expect(position).to_not be_valid
        expect(position.errors[:name]).to include 'não pode ficar em branco'
        expect(position.errors[:description]).to include 'não pode ficar em branco'
        expect(position.errors[:code]).to include 'não pode ficar em branco'
        expect(position.errors[:department]).to include 'é obrigatório(a)'
      end
    end

    it 'formato do código' do
      position = build(:position, code: 'ABC1234')

      expect(position).to_not be_valid
      expect(position.errors[:code]).to include 'Formato: 3 letras maiúsculas seguidas por 3 números (ex.: XYZ567)'
    end
  end
end
