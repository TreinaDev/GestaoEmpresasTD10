require 'rails_helper'

RSpec.describe Department, type: :model do
  describe '#code' do
    it 'formato incorreto' do
      department = build(:department, code: '5as1')
      result = department.valid?

      expect(result).to be false
      expect(department.errors[:code]).to include 'o código deve ser composto por 3 letras e 6 caracteres'
    end

    it 'e unico' do
      create(:department, code: 'COD123')
      company = create(:company, registration_number: '12.566.284/0001-67')
      department = build(:department, company:, code: 'COD123')

      result = department.valid?

      expect(result).to be false
      expect(department.errors[:code]).to include 'já está em uso'
    end
  end

  describe '#valid?' do
    it 'Nome deve ser obrigatório' do
      department = build(:department, name: '')

      expect(department.valid?).to be false
      expect(department.errors[:name]).to include 'não pode ficar em branco'
    end

    it 'Código deve ser obrigatório' do
      department = build(:department, code: '')

      expect(department.valid?).to be false
      expect(department.errors[:code]).to include 'não pode ficar em branco'
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
