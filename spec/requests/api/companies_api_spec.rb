require 'rails_helper'

describe 'Companies API' do
  context 'GET /api/v1/companies/' do
    it 'e visualiza todas as empresas' do
      company1 = create(:company, registration_number: '987654321', brand_name: 'Campus Code',
                                  corporate_name: 'Campus Code Treinamentos LTDA')
      company2 = create(:company, registration_number: '123456789', brand_name: 'McDonalds',
                                  corporate_name: 'Arcos Dourados')

      get '/api/v1/companies'
      json_response = response.parsed_body

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

    it 'e visualiza lista vazia' do
      get '/api/v1/companies'
      json_response = response.parsed_body

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response).to eq []
    end

    it 'e visualiza empresa pelo CNPJ' do
      company1 = create(:company, registration_number: '987654321', brand_name: 'Campus Code',
                                  corporate_name: 'Campus Code Treinamentos LTDA')
      company2 = create(:company, registration_number: '123456789', brand_name: 'McDonalds',
                                  corporate_name: 'Arcos Dourados')
      company3 = create(:company, registration_number: '567890123', brand_name: 'Apple', corporate_name: 'Maça de ouro')

      get "/api/v1/companies?cnpj=#{company2.registration_number}"
      json_response = response.parsed_body

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response['brand_name']).to eq 'McDonalds'
      expect(json_response['corporate_name']).to eq 'Arcos Dourados'
      expect(json_response['id']).to eq company2.id
      expect(json_response['active']).to eq true
      expect(json_response).not_to include 'Campus Code'
      expect(json_response).not_to include 'Campus Code Treinamentos LTDA'
      expect(json_response).not_to include company1.id
      expect(json_response).not_to include 'Apple'
      expect(json_response).not_to include 'Maça de ouro'
      expect(json_response).not_to include company3.id
    end
  end
end
