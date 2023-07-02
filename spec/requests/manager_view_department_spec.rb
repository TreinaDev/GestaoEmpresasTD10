require 'rails_helper'

describe 'Gerente tenta acessar departamento', type: :request do
  it 'com sucesso' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    create(:employee_profile, position:, department_id: position.department.id,
                              status: 'unblocked', email: "funcionario@#{company.domain}",
                              cpf: '90900938005', card_status: true)
    create(:employee_profile, :manager, department:, position:,
                                        user: manager, email: manager.email)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as(manager)

    get company_department_path(company_id: company.id, id: department.id)

    expect(response).to have_http_status 200
  end

  it 'e é redirecionado para a página principal devido ao departamento ser de outra empresa' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    create(:employee_profile, position:, department_id: position.department.id,
                              status: 'unblocked', email: "funcionario@#{company.domain}",
                              cpf: '90900938005', card_status: true)
    create(:user, email: "funcionario@#{company.domain}", password: 'password',
                  cpf: '90900938005')

    company2 = create(:company, brand_name: 'Monstros SA', domain: 'monstrossa.com',
                                registration_number: '33400500000155',
                                address: 'rua dos monstros 44',
                                phone_number: '828888888', email: 'contato@monstrossa.com',
                                corporate_name: 'Monstros Energia SA')
    department_company2 = create(:department, company: company2)
    position_company2 = create(:position, department: department_company2)
    create(:manager_emails, created_by: admin_user, company: company2, email: "nome@#{company2.domain}")
    manager2 = create(:manager_user, email: "nome@#{company2.domain}", cpf: '09814576492')
    create(:employee_profile, :manager, department: department_company2, position: position_company2,
                                        user: manager2, email: manager2.email)
    login_as(manager2)

    get company_department_path(company_id: company.id, id: department.id)

    follow_redirect!
    follow_redirect!

    expect(response.body).to include 'Usuário sem permissão para executar essa ação'
  end
end
