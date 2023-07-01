require 'rails_helper'

feature 'Manager vê um departamento em específico' do
  scenario 'Com sucesso' do
    admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
    company = create(:company, :with_department)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    create(:employee_profile, :manager, user: manager)
    department = create(:department, name: 'Juridico', description: 'Setor de Processos', company:)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as manager
    visit company_department_path(company, department)

    expect(page).to have_content 'Juridico'
    expect(page).to have_content 'Setor de Processos'
    expect(page).to have_content 'Campus Code'
    expect(page).to have_content department.code
    expect(page).to have_link 'Editar Departamento'
    expect(page).to have_link 'Cadastrar cargo'
    expect(page).to have_link 'Voltar'
  end

  scenario 'E vê também a lista de funcionários deste departamento' do
    admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
    company = create(:company, :with_department)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    create(:employee_profile, :manager, user: manager)
    department = create(:department, name: 'Juridico', description: 'Setor de Processos', company:)
    second_department = create(:department, name: 'Cozinha', description: 'Alimentos', company:)
    position = create(:position, department_id: department.id)
    second_position = create(:position, department_id: department.id, name: 'Programador')
    create(:employee_profile, :employee, user: manager, position: second_position, department:, cpf: '16576262027')
    create(:employee_profile, :employee, user: manager, position:, department: second_department,
                                         name: 'Roberval Silva', cpf: '09602079029',
                                         email: "secondemployee@#{company.domain}")

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as manager
    visit company_department_path(company, department)

    expect(page).to have_content 'Roberto Carlos Nascimento'
    expect(page).to have_content 'Roberto Carlos Nascimento'
    expect(page).to have_content 'Ativo'
    expect(page).to have_content '165.762.620-27'
    expect(page).to have_content 'Programador'
    expect(page).not_to have_content 'Roberval'
    expect(page).not_to have_content '096.020.790-29'
  end

  scenario 'E não há funcionários no departamento' do
    admin = create(:user, cpf: '57049003050', email: 'admin@punti.com')
    company = create(:company, :with_department)
    create(:manager_emails, created_by: admin, company:)
    manager = create(:manager_user)
    create(:employee_profile, :manager, user: manager)
    department = create(:department, name: 'Juridico', description: 'Setor de Processos', company:)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as manager
    visit company_department_path(company, department)

    expect(page).to have_content 'Não há funcionários neste departamento até o momento.'
  end
end
