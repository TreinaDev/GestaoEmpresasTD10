require 'rails_helper'

feature 'Manager faz uma recarga ao cartão' do
  scenario 'mas confirma os dados primeiro' do
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

    login_as manager_user
    visit new_company_recharge_history_path(company_id: company.id)

    fill_in 'cpf',	with: '909.009.380-05'
    fill_in 'value',	with: '400'
    click_button 'Buscar'

    expect(page).to have_content 'Confirmar Recarga'
    expect(page).to have_content "Nome: #{employee.name}"
    expect(page).to have_content "Cargo: #{employee.position.name}"
    expect(page).to have_content "Departamento: #{employee.department.name}"
    expect(page).to have_content 'CPF: 909.009.380-05'
    expect(page).to have_content 'Valor: R$ 400,00'
    expect(page).to have_content "Nome: #{employee.name}"
    expect(RechargeHistory.count).to eq 0
  end

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
    fake_response = double('faraday_response', status: 200, body: '[{"message":"Recarga efetuada com sucesso"}]')
    allow(Faraday).to receive(:patch)
      .with('http://localhost:4000/api/v1/cards/recharge',
        request.to_json,
        'Content-Type' => 'application/json')
      .and_return(fake_response)  

    login_as manager_user  
    visit new_company_recharge_history_path(company_id: company.id)

    fill_in 'cpf',	with: '909.009.38-005'
    fill_in 'value',	with: '400'
    click_button 'Buscar'
    click_button 'Recarregar'

    expect(page).to have_content 'Recarga efetuada com sucesso'
    expect(RechargeHistory.last.value).to eq 400
  end

  scenario 'com CPF não encontrado na empresa do Manager' do
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

    company2 = create(:company,                                     
      brand_name: 'Outra empresa', corporate_name: 'OE SA', registration_number: '12345678901234',
      email: 'contato@oe.com', domain: 'oe.com'
    )  
    department2 = create(:department, company: company2)
    position2 = create(:position, code: 'BAC132', department: department2)
    employee2 = create(:employee_profile,
      department: department2, position: position2, user: nil, name: 'Funcionario2', card_status: true,
      social_name: 'Func2', email: "funcionario2@#{company2.domain}", cpf: '30448522500'
    )  

    login_as manager_user
    visit new_company_recharge_history_path(company_id: company.id)

    fill_in 'Cpf',	with: '30448522500'
    fill_in 'Value',	with: '400'
    click_button 'Enviar'

    expect(employee2.cpf).to eq '30448522500'
    expect(page).to have_content 'CPF não encontrado: 30448522500'
  end

  scenario 'com API indisponível' do
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
    fake_response = double('faraday_response', status: 500, body: '{}')
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

    expect(page).to have_content 'ERRO de conexão'
  end

  context 'de funcionário sem permissão para recarga' do
    scenario 'com status blocked' do
      company = create(:company)
      department = create(:department, company:)
      admin_user = create(:admin_user)
      create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
      manager_user = create(:manager_user, email: "nome@#{company.domain}")
      position = create(:position, department:)
      create(:employee_profile, :manager, department:, position:, user: manager_user, name: 'arthur',
                                          social_name: 'arthur arthur')
      employee = create(:employee_profile, position:, department_id: position.department.id,                                    
                                           status: 'blocked', email: "funcionario@#{company.domain}",
                                           cpf: '90900938005',
                                           card_status: true)
  
      login_as manager_user                                     
      visit new_company_recharge_history_path(company_id: company.id)
  
      fill_in 'Cpf',	with: '90900938005'
      fill_in 'Value',	with: '400'
      click_button 'Enviar'
  
      expect(page).to have_content 'Funcionário com status incorreto: Bloqueado'
    end

    scenario 'com status fired' do
      company = create(:company)
      department = create(:department, company:)
      admin_user = create(:admin_user)
      create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
      manager_user = create(:manager_user, email: "nome@#{company.domain}")
      position = create(:position, department:)
      create(:employee_profile, :manager, department:, position:, user: manager_user, name: 'arthur',
                                          social_name: 'arthur arthur')
      employee = create(:employee_profile, position:, department_id: position.department.id,                                    
                                           status: 'fired', email: "funcionario@#{company.domain}",
                                           cpf: '90900938005',
                                           card_status: true)
  
      login_as manager_user                                     
      visit new_company_recharge_history_path(company_id: company.id)
  
      fill_in 'Cpf',	with: '90900938005'
      fill_in 'Value',	with: '400'
      click_button 'Enviar'
  
      expect(page).to have_content 'Funcionário com status incorreto: Demitido'
    end

    scenario 'sem cartão emitido' do
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
                                           card_status: false)
  
      login_as manager_user                                     
      visit new_company_recharge_history_path(company_id: company.id)
  
      fill_in 'Cpf',	with: '90900938005'
      fill_in 'Value',	with: '400'
      click_button 'Enviar'
  
      expect(page).to have_content 'Cartão não solicitado para esse CPF: 90900938005'
    end
  end

  context 'Sem autorização' do
    scenario 'logado como admin' do
      company = create(:company)
      admin_user = create(:admin_user)

      login_as admin_user
      visit new_company_recharge_history_path(company_id: company.id)

      expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    end

    scenario 'logado como Manager de outra empresa' do
      company = create(:company)
      department = create(:department, company:)
      admin_user = create(:admin_user)
      create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
      manager_user = create(:manager_user, email: "nome@#{company.domain}")
      position = create(:position, department:)
      create(:employee_profile, :manager, department:, position:, user: manager_user, name: 'arthur',
                                          social_name: 'arthur arthur')

      company2 = create(:company,
        brand_name: 'Outra empresa', corporate_name: 'OE SA', registration_number: '12345678901234',
        email: 'contato@oe.com', domain: 'oe.com'
      )

      login_as manager_user
      visit new_company_recharge_history_path(company_id: company2.id)

      expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    end

    scenario 'logado como Funcionário' do
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
      employee_user = create(:user, cpf: employee.cpf, email: employee.email)

      login_as employee_user
      visit new_company_recharge_history_path(company_id: company.id)

      expect(page).to have_content 'Usuário sem permissão para executar essa ação'
    end
  end
end
