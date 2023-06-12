require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#valido?' do
    it 'inválido quando nome fantasia fica em branco' do
      company = Company.new(status: true)

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
  end
end
