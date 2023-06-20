require 'rails_helper'

RSpec.describe Department, type: :model do
  describe '#code' do
    it 'e único' do
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('COD123')
      create(:department)
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('COD123')
      company = create(:company, registration_number: '12.566.284/0001-67')
      department = build(:department, company:)

      result = department.valid?

      expect(result).to be false
      expect(department.errors[:code]).to include 'já está em uso'
    end

    it 'e gerado automático' do
      department = build(:department, code: nil)

      result = department.valid?

      expect(result).to be true
      expect(department.errors.size).to eq 0
    end
  end

  describe '#valid?' do
    it 'Nome deve ser obrigatório' do
      department = build(:department, name: '')

      expect(department.valid?).to be false
      expect(department.errors[:name]).to include 'não pode ficar em branco'
    end

    it 'Descrição deve ser obrigatório' do
      department = build(:department, description: '')

      expect(department.valid?).to be false
      expect(department.errors[:description]).to include 'não pode ficar em branco'
    end

    it 'Empresa deve ser obrigatória' do
      department = build(:department, company: nil)

      expect(department.valid?).to be false
      expect(department.errors[:company]).to include 'é obrigatório(a)'
    end
  end
end
