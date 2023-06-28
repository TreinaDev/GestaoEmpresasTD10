require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'Status' do
    it 'retorna 500 quando sistema está indisponível' do
      response = GetCardType.status

      expect(response).to eq 500
    end
  end
end