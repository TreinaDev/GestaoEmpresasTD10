require 'rails_helper'

describe 'Company API' do
  context 'GET /api/v1/companies/1' do
    it 'com sucesso' do
      company = create(:company)

      get "/api/v1/companies/#{company.id}"
      json_response = response.parsed_body

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response['brand_name']).to eq 'Campus Code'
      expect(json_response['corporate_name']).to eq 'Campus Code Treinamentos LTDA'
      expect(json_response['id']).to eq company.id
      expect(json_response['active']).to eq true
    end

    it 'sem sucesso, quando id for inválido' do
      create(:company)

      get '/api/v1/companies/6846843'
      json_response = response.parsed_body

      expect(response.status).to eq 404
      expect(json_response['errors']).to include 'Página não encontrada'
    end
  end
end
