require 'rails_helper'

describe 'Companies API' do
  context 'POST /api/v1/companies/' do
    it 'com sucesso' do
      company = create(:company)
      company_params = {
        company: {
          registration_number: company.registration_number,
          brand_name: company.brand_name,
          corporate_name: company.corporate_name,
          active: company.active
        }
      }

      fake_response = double('faraday_response', status: 201, body: '{}')
      allow(Faraday).to receive(:post)
        .with('http://localhost:5000/api/v1/companies',
              company_params.to_json)
        .and_return(fake_response)

      expect(fake_response.status).to eq 201
    end
  end
end
