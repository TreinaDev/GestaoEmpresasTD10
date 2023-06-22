require 'rails_helper'

feature 'Gerente vai para index do departamento' do
  scenario 'e bloqueia cartão de funcionário' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    employee_profile = create(:employee_profile, position:, department_id: position.department.id,
                                                 status: 'unblocked', email: "funcionario@#{company.domain}",
                                                 cpf: '90900938005', card_status: true)
    create(:user, email: "funcionario@#{company.domain}", password: 'password',
                  cpf: '90900938005')

    json_data = '{}'
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:patch).with("http://localhost:4000/api/v1/cards/#{employee_profile.cpf}/deactivate").and_return(fake_response.status)

    login_as(manager_user)
    visit company_departments_path(company_id: company.id)
    click_on 'RH'
    within('div#1') do
      click_on 'Bloquear Cartão'
    end

    expect(page).to have_content 'Cartão bloqueado'
    within('div#1') do
      expect(page).to have_button 'Desbloquear'
      expect(page).to_not have_button 'Solicitar Cartão'
      expect(page).to_not have_button 'Bloquear Cartão'
    end
  end
end