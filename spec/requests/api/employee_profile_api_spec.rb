require 'rails_helper'

describe 'Employee Profiles API' do
  context 'GET /api/v1/employee_profiles' do
    it 'e visualiza todos os funcionários' do
      company = create(:company)
      company2 = create(:company, registration_number: '12345678901')
      department = create(:department, company:)
      department2 = create(:department, company: company2, code: 'XYZ456')
      position = create(:position, department:)
      position2 = create(:position, department: department2, code: 'POS999')
      create(:employee_profile, name: 'Whitney Houston', cpf: '69142235219', status: 'unblocked',
                                department: department2, position: position2)
      create(:employee_profile, name: 'Beyonce Knowles', cpf: '66353795092', status: 'blocked', department:, position:)
      create(:employee_profile, name: 'Michael Jackson', cpf: '12117237045', status: 'fired', department:, position:)

      get '/api/v1/employee_profiles'
      json_response = response.parsed_body

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response[0]['name']).to eq 'Whitney Houston'
      expect(json_response[0]['cpf']).to eq '69142235219'
      expect(json_response[0]['status']).to eq 'unblocked'
      expect(json_response[0]['company_cnpj']).to eq company2.registration_number
      expect(json_response[1]['name']).to eq 'Beyonce Knowles'
      expect(json_response[1]['cpf']).to eq '66353795092'
      expect(json_response[1]['status']).to eq 'blocked'
      expect(json_response[1]['company_cnpj']).to eq company.registration_number
      expect(json_response[2]['name']).to eq 'Michael Jackson'
      expect(json_response[2]['cpf']).to eq '12117237045'
      expect(json_response[2]['status']).to eq 'fired'
      expect(json_response[2]['company_cnpj']).to eq company.registration_number
    end

    it 'e visualiza um funcionário selecionado pelo cpf' do
      company = create(:company)
      company2 = create(:company, registration_number: '12345678901')
      department = create(:department, company:)
      department2 = create(:department, company: company2, code: 'XYZ456')
      position = create(:position, department:)
      position2 = create(:position, department: department2, code: 'POS999')
      create(:employee_profile, name: 'Whitney Houston', cpf: '69142235219', status: 'unblocked',
                                department: department2, position: position2)
      create(:employee_profile, name: 'Beyonce Knowles', cpf: '66353795092', status: 'blocked', department:, position:)
      create(:employee_profile, name: 'Michael Jackson', cpf: '12117237045', status: 'fired', department:, position:)

      get '/api/v1/employee_profiles?cpf=66353795092'
      json_response = response.parsed_body

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response).not_to include 'Whitney Houston'
      expect(json_response).not_to include '69142235219'
      expect(json_response).not_to include 'unblocked'
      expect(json_response).not_to include company2.registration_number
      expect(json_response[0]['name']).to eq 'Beyonce Knowles'
      expect(json_response[0]['cpf']).to eq '66353795092'
      expect(json_response[0]['status']).to eq 'blocked'
      expect(json_response[0]['company_cnpj']).to eq company.registration_number
      expect(json_response).not_to include 'Michael Jackson'
      expect(json_response).not_to include '12117237045'
      expect(json_response).not_to include 'fired'
    end

    it 'e visualiza funcionários selecionados pelo status' do
      company = create(:company)
      company2 = create(:company, registration_number: '12345678901')
      department = create(:department, company:)
      department2 = create(:department, company: company2, code: 'XYZ456')
      position = create(:position, department:)
      position2 = create(:position, department: department2, code: 'POS999')
      create(:employee_profile, name: 'Whitney Houston', cpf: '69142235219', status: 'unblocked',
                                department: department2, position: position2)
      create(:employee_profile, name: 'Beyonce Knowles', cpf: '66353795092', status: 'blocked', department:, position:)
      create(:employee_profile, name: 'Michael Jackson', cpf: '12117237045', status: 'fired', department:, position:)
      create(:employee_profile, name: 'Lady Gaga', cpf: '12146825618', status: 'unblocked', department:, position:)

      get '/api/v1/employee_profiles?status=unblocked'
      json_response = response.parsed_body

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      expect(json_response[0]['name']).to eq 'Whitney Houston'
      expect(json_response[0]['cpf']).to eq '69142235219'
      expect(json_response[0]['status']).to eq 'unblocked'
      expect(json_response[0]['company_cnpj']).to eq company2.registration_number
      expect(json_response[1]['name']).to eq 'Lady Gaga'
      expect(json_response[1]['cpf']).to eq '12146825618'
      expect(json_response[1]['status']).to eq 'unblocked'
      expect(json_response[1]['company_cnpj']).to eq company.registration_number

      expect(json_response).not_to include 'Beyonce Knowles'
      expect(json_response).not_to include '66353795092'
      expect(json_response).not_to include 'blocked'
      expect(json_response).not_to include 'Michael Jackson'
      expect(json_response).not_to include '12117237045'
      expect(json_response).not_to include 'fired'
    end

    it 'retorna no_content quando a lista estiver vazia' do
      get '/api/v1/employee_profiles'

      expect(response.status).to eq 204
    end

    it 'retorna no_content quando o cpf não existe' do
      company = create(:company)
      company2 = create(:company, registration_number: '12345678901')
      department = create(:department, company:)
      department2 = create(:department, company: company2, code: 'XYZ456')
      position = create(:position, department:)
      position2 = create(:position, department: department2, code: 'POS999')
      create(:employee_profile, name: 'Whitney Houston', cpf: '69142235219', status: 'unblocked',
                                department: department2, position: position2)
      create(:employee_profile, name: 'Beyonce Knowles', cpf: '66353795092', status: 'blocked', department:, position:)
      create(:employee_profile, name: 'Michael Jackson', cpf: '12117237045', status: 'fired', department:, position:)

      get '/api/v1/employee_profiles?cpf=66353795999'
      json_response = response.parsed_body

      expect(response.status).to eq 204
      expect(json_response).not_to include 'Whitney Houston'
      expect(json_response).not_to include '69142235219'
      expect(json_response).not_to include 'unblocked'
      expect(json_response).not_to include company2.registration_number
      expect(json_response).not_to include 'Beyonce Knowles'
      expect(json_response).not_to include '66353795092'
      expect(json_response).not_to include 'blocked'
      expect(json_response).not_to include company.registration_number
      expect(json_response).not_to include 'Michael Jackson'
      expect(json_response).not_to include '12117237045'
      expect(json_response).not_to include 'fired'
    end

    it 'retorna no_content quando o status não existe' do
      company = create(:company)
      company2 = create(:company, registration_number: '12345678901')
      department = create(:department, company:)
      department2 = create(:department, company: company2, code: 'XYZ456')
      position = create(:position, department:)
      position2 = create(:position, department: department2, code: 'POS999')
      create(:employee_profile, name: 'Whitney Houston', cpf: '69142235219', status: 'unblocked',
                                department: department2, position: position2)
      create(:employee_profile, name: 'Beyonce Knowles', cpf: '66353795092', status: 'blocked', department:, position:)
      create(:employee_profile, name: 'Michael Jackson', cpf: '12117237045', status: 'fired', department:, position:)
      create(:employee_profile, name: 'Lady Gaga', cpf: '12146825618', status: 'unblocked', department:, position:)

      get '/api/v1/employee_profiles?status=unblock'
      json_response = response.parsed_body

      expect(response.status).to eq 204
      expect(json_response).not_to include 'Whitney Houston'
      expect(json_response).not_to include '69142235219'
      expect(json_response).not_to include 'unblocked'
      expect(json_response).not_to include company2.registration_number
      expect(json_response).not_to include 'Lady Gaga'
      expect(json_response).not_to include '12146825618'
      expect(json_response).not_to include 'unblocked'
      expect(json_response).not_to include company.registration_number
      expect(json_response).not_to include 'Beyonce Knowles'
      expect(json_response).not_to include '66353795092'
      expect(json_response).not_to include 'blocked'
      expect(json_response).not_to include 'Michael Jackson'
      expect(json_response).not_to include '12117237045'
      expect(json_response).not_to include 'fired'
    end
  end
end
