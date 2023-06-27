require 'rails_helper'

describe 'Gerente tenta acessar departamente de outra empresas', type: :request do
  it 'e é redirecionado para a página principal' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    employee_profile = create(:employee_profile, position:, department_id: position.department.id,
                                                 status: 'unblocked', email: "funcionario@#{company.domain}",
                                                 cpf: '90900938005', card_status: true)
    create(:user, email: "funcionario@#{company.domain}", password: 'password',
                  cpf: '90900938005')

    company2 = create(:company, brand_name: 'Monstros SA', domain: 'monstrossa.com',
                                registration_number: '33400500000155',
                                address: 'rua dos monstros 44',
                                phone_number: '828888888', email: 'contato@monstrossa.com',
                                corporate_name: 'Monstros Energia SA')
    create(:department, company: company2)
    create(:manager_emails, created_by: admin_user, company: company2, email: "nome@#{company2.domain}")
    manager2 = create(:manager_user, email: "nome@#{company2.domain}", cpf: '09814576492')

    login_as(manager2)

    get company_department_employee_profile_path(company_id: company.id, department_id: department.id,
                                                 id: employee_profile.id)

    expect(response).to redirect_to root_path
  end
end
