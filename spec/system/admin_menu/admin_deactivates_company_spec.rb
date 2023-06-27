require 'rails_helper'

feature 'Admin desativa empresa' do
  scenario 'e todos os funcionários são marcados como inatavos' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    create(:employee_profile, :manager, department:, position:, user: manager_user, card_status: false)
    create(:employee_profile, :employee, position:, department_id: position.department.id,
                                         status: 'unblocked', email: "funcionario@#{company.domain}",
                                         cpf: '90900938005', card_status: true)
    create(:employee_profile, :employee, position:, department_id: position.department.id,
                                         name: 'Josephina', status: 'unblocked',
                                         email: "funcionario2@#{company.domain}", cpf: '91401225063',
                                         card_status: false)

    json_data = Rails.root.join('spec/support/json/cards.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/cards/90900938005').and_return(fake_response)

    json_data2 = '{}'
    fake_response2 = double('faraday_response', status: 200, body: json_data2)
    allow(Faraday).to receive(:patch).with("http://localhost:4000/api/v1/cards/#{JSON.parse(fake_response.body)['id']}/deactivate").and_return(fake_response2)

    login_as(admin_user)
    visit root_path
    within("div#cpn#{company.id}") do
      click_on 'Ver Detalhes'
    end
    click_on 'Desativar'
    company.reload

    expect(page).to_not have_button 'Desativar'
    expect(page).to have_button 'Ativar'
    expect(fake_response2.status).to eq 200
    expect(EmployeeProfile.first.status).to eq 'blocked'
    expect(EmployeeProfile.second.status).to eq 'blocked'
    expect(EmployeeProfile.last.status).to eq 'blocked'
    expect(company.active).to eq false
  end

  scenario 'empresa ja está desativa e é reativa pelo admin e funcionários são marcados como unblocked' do
    company = create(:company)
    department = create(:department, company:)
    admin_user = create(:admin_user)
    create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
    manager_user = create(:manager_user, email: "nome@#{company.domain}")
    position = create(:position, department:)
    create(:employee_profile, :manager, department:, position:, user: manager_user)
    create(:employee_profile, :employee, position:, department_id: position.department.id,
                                         status: 'unblocked', email: "funcionario@#{company.domain}",
                                         cpf: '90900938005')
    create(:employee_profile, :employee, position:, department_id: position.department.id,
                                         name: 'Josephina', status: 'unblocked',
                                         email: "funcionario2@#{company.domain}", cpf: '91401225063')
    company.update(active: false)
    company.reload

    json_data = Rails.root.join('spec/support/json/cards2.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/cards/90900938005').and_return(fake_response)

    json_data2 = '{}'
    fake_response2 = double('faraday_response', status: 200, body: json_data2)
    allow(Faraday).to receive(:patch).with("http://localhost:4000/api/v1/cards/#{JSON.parse(fake_response.body)['id']}/activate").and_return(fake_response2)

    login_as(admin_user)
    visit company_path(id: company.id)
    click_on 'Ativar'
    company.reload

    expect(page).to have_button 'Desativar'
    expect(page).not_to have_button 'Ativar'
    expect(fake_response2.status).to eq 200
    expect(EmployeeProfile.first.status).to eq 'unblocked'
    expect(EmployeeProfile.second.status).to eq 'unblocked'
    expect(EmployeeProfile.last.status).to eq 'unblocked'
    expect(company.active).to eq true
  end
end
