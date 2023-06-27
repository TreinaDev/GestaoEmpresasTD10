require 'rails_helper'

feature 'Manager faz uma recarga ao cartão de um funcionário' do 
  scenario 'com sucesso' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    create(:employee_profile, :manager, department:, position:, user: manager_user, name: 'arthur',
                                        social_name: 'arthur arthur')
    employee = create(:employee_profile, position:, department_id: position.department.id,
                                         status: 'unblocked', email: "funcionario@#{company.domain}",
                                         cpf: '90900938005',
                                         card_status: true)

    request = { recharge: [{ value: 400, cpf: '90900938005' }] }
    fake_response = double('faraday_response', status: 200, body: '{}')
    allow(Faraday).to receive(:patch)
      .with('http://localhost:4000/api/v1/cards/recharge',
        request.to_json,
        'Content-Type' => 'application/json')
      .and_return(fake_response)

    login_as manager_user
    visit new_company_recharge_history_path(company_id: company.id)

    fill_in 'Cpf',	with: '90900938005' 
    fill_in 'Value',	with: '400'
    click_button 'Enviar'

    expect(page).to have_content 'SUCESSO'
  end
end