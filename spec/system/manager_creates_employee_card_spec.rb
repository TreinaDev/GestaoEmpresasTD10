require 'rails_helper'

feature 'Gerente vai para index do departamento' do
  scenario 'e vê todos os funcionários do departamento' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    create(:employee_profile, position:, department_id: position.department.id,
                              status: 'unblocked', email: "funcionario@#{company.domain}", cpf: '90900938005')
    create(:user, email: "funcionario@#{company.domain}", password: 'password', cpf: '90900938005')

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)
    click_on 'RH'

    expect(current_path).to eq company_department_path(company_id: company.id, id: department.id)
    expect(page).to have_content 'Nome: RH'
    expect(page).to have_content 'Funcionários: Roberto Carlos Nascimento'
    expect(page).to have_button 'Solicitar Cartão'
  end

  scenario 'e solicita cartão com sucesso' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    employee_profile = create(:employee_profile, position:, department_id: position.department.id,
                                                 status: 'unblocked', email: "funcionario@#{company.domain}",
                                                 cpf: '90900938005')
    create(:user, email: "funcionario@#{company.domain}", password: 'password',
                  cpf: '90900938005')

    json_data = 'Cartão cadastrado com sucesso'
    fake_response = double('faraday_response', status: 201, body: json_data)
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/cards',
                                          { card: { company_card_type_id: position.card_type_id.to_s,
                                                    cpf: employee_profile.cpf } }.to_json,
                                          'Content-Type' => 'application/json')
                                    .and_return(fake_response)

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)
    click_on 'RH'
    within('div#1') do
      click_on 'Solicitar Cartão'
    end

    expect(current_path).to eq company_department_path(company_id: company.id, id: department.id)
    within('div#1') do
      expect(page).to_not have_button('Solicitar Cartão')
    end
    expect(page).to have_content 'Cartão cadastrado com sucesso'
    expect(fake_response.body).to eq 'Cartão cadastrado com sucesso'
  end
end
