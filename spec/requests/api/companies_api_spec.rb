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

    it 'retorna no_content quando a lista estiver vazia' do
      get '/api/v1/companies'

      expect(response.status).to eq 204
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
      expect(json_response[0]['brand_name']).to eq 'McDonalds'
      expect(json_response[0]['corporate_name']).to eq 'Arcos Dourados'
      expect(json_response[0]['id']).to eq company2.id
      expect(json_response[0]['active']).to eq true
      expect(json_response).not_to include 'Campus Code'
      expect(json_response).not_to include 'Campus Code Treinamentos LTDA'
      expect(json_response).not_to include company1.id
      expect(json_response).not_to include 'Apple'
      expect(json_response).not_to include 'Maça de ouro'
      expect(json_response).not_to include company3.id
    end

    it 'retorna no_content quando o CNPJ não é encontrado' do
      company1 = create(:company, registration_number: '987654321', brand_name: 'Campus Code',
                                  corporate_name: 'Campus Code Treinamentos LTDA')
      company2 = create(:company, registration_number: '123456789', brand_name: 'McDonalds',
                                  corporate_name: 'Arcos Dourados')
      company3 = create(:company, registration_number: '567890123', brand_name: 'Apple', corporate_name: 'Maça de ouro')

      get '/api/v1/companies?cnpj=12345678910'
      json_response = response.parsed_body

      expect(response.status).to eq 204
      expect(json_response).not_to include 'McDonalds'
      expect(json_response).not_to include 'Arcos Dourados'
      expect(json_response).not_to include company2.id.to_s
      expect(json_response).not_to include true.to_s
      expect(json_response).not_to include 'Campus Code'
      expect(json_response).not_to include 'Campus Code Treinamentos LTDA'
      expect(json_response).not_to include company1.id.to_s
      expect(json_response).not_to include 'Apple'
      expect(json_response).not_to include 'Maça de ouro'
      expect(json_response).not_to include company3.id.to_s
    end

    it 'e visualiza empresa pelo status' do
      company = create(:company, registration_number: '987654321', brand_name: 'Campus Code',
                                 corporate_name: 'Campus Code Treinamentos LTDA', active: true)
      company2 = create(:company, registration_number: '123456789', brand_name: 'McDonalds',
                                  corporate_name: 'Arcos Dourados', active: true)
      company3 = create(:company, registration_number: '567890123', brand_name: 'Apple',
                                  corporate_name: 'Maça de ouro', active: false)

      get '/api/v1/companies?active=true'
      json_response = response.parsed_body

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response[0]['brand_name']).to eq 'Campus Code'
      expect(json_response[0]['corporate_name']).to eq 'Campus Code Treinamentos LTDA'
      expect(json_response[0]['id']).to eq company.id
      expect(json_response[0]['active']).to eq true
      expect(json_response[1]['brand_name']).to eq 'McDonalds'
      expect(json_response[1]['corporate_name']).to eq 'Arcos Dourados'
      expect(json_response[1]['id']).to eq company2.id
      expect(json_response[1]['active']).to eq true
      expect(json_response).not_to include 'Apple'
      expect(json_response).not_to include 'Maça de ouro'
      expect(json_response).not_to include company3.id
      expect(json_response).not_to include company3.active
    end
  end
end
