require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#valido?' do
    it 'inválido quando os campos ficam em branco' do
      company = Company.new(active: true)

      expect(company).not_to be_valid
      expect(company.errors[:brand_name]).to include('não pode ficar em branco')
      expect(company.errors[:corporate_name]).to include('não pode ficar em branco')
      expect(company.errors[:registration_number]).to include('não pode ficar em branco')
      expect(company.errors[:address]).to include('não pode ficar em branco')
      expect(company.errors[:phone_number]).to include('não pode ficar em branco')
      expect(company.errors[:email]).to include('não pode ficar em branco')
      expect(company.errors[:domain]).to include('não pode ficar em branco')
      expect(company.errors[:brand_name]).to include('não pode ficar em branco')
      expect(company.errors[:logo]).to include('não pode ficar em branco')
    end

    it 'inválido quando CNPJ já existe' do
      create(:company, registration_number: '00.394.460/0058-87')
      other_company = build(:company, registration_number: '00.394.460/0058-87')

      expect(other_company).not_to be_valid
      expect(other_company.errors[:registration_number].size).to eq 1
      expect(other_company.errors[:registration_number]).to include 'já está em uso'
    end
  end
end
