require 'rails_helper'

describe 'Company API' do
  context 'GET /api/v1/companies/1' do
    it 'com sucesso' do
      company = create(:company)

      get "/api/v1/companies/#{company.id}"
      json_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response['brand_name']).to eq 'Campus Code'
      expect(json_response['corporate_name']).to eq 'Campus Code Treinamentos LTDA'
      expect(json_response['id']).to eq company.id
      expect(json_response['active']).to eq true
    end

    it 'sem sucesso, quando id for inválido' do
      create(:company)

      get "/api/v1/companies/6846843"
      json_response = JSON.parse(response.body)

      expect(response.status).to eq 404
      expect(json_response['errors']).to include 'Página não encontrada'
    end
  end

  context 'GET /api/v1/companies/' do
    it 'com sucesso e visualiza empresas' do
      company1 = create(:company, registration_number: '987654321', brand_name: 'Campus Code', corporate_name: 'Campus Code Treinamentos LTDA')
      company2 = create(:company, registration_number: '123456789', brand_name: 'McDonalds', corporate_name: 'Arcos Dourados')

      get "/api/v1/companies"
      json_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response[0]['brand_name']).to eq 'Campus Code'
      expect(json_response[1]['brand_name']).to eq 'McDonalds'
      expect(json_response[0]['corporate_name']).to eq 'Campus Code Treinamentos LTDA'
      expect(json_response[1]['corporate_name']).to eq 'Arcos Dourados'
      expect(json_response[0]['id']).to eq company1.id
      expect(json_response[1]['id']).to eq company2.id
      expect(json_response[0]['active']).to eq true
      expect(json_response[1]['active']).to eq true
    end

    it 'com sucesso e vazio' do
      get "/api/v1/companies"
      json_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response).to eq []
    end
  end
end
