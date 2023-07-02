require 'rails_helper'

feature 'Manager faz recarga de todos os cartões da empresa' do
  scenario 'mas confirma os dados primeiro' do
    company = create(:company, domain: 'empresa1.com')
    department = create(:department, company:)
    position = create(:position, department:)
    create(:manager_emails, company:, email: 'manager@empresa1.com')
    manager_user = create(:manager_user, email: 'manager@empresa1.com', cpf: '69142235219')
    manager = create(
      :employee_profile,
      department:,
      position:,
      email: 'manager@empresa1.com',
      cpf: '69142235219',
      status: 'unblocked',
      user: manager_user,
      name: 'Nome Gerente',
      social_name: 'Nome Gerente',
      card_status: true
    )

    employee1 = create(
      :employee_profile,
      position:,
      department:,
      name: 'Func Um',
      social_name: 'Func Um',
      status: 'unblocked',
      email: 'funcionario1@empresa1.com',
      cpf: '15703243017',
      card_status: true
    )

    employee2 = create(
      :employee_profile,
      position:,
      department:,
      name: 'Func Dois',
      social_name: 'Func Dois',
      status: 'unblocked',
      email: 'funcionario2@empresa1.com',
      cpf: '29963810926',
      card_status: true
    )

    create(
      :employee_profile,
      position:,
      department:,
      name: 'Func Tres',
      social_name: 'Func Tres',
      status: 'fired',
      email: 'funcionario3@empresa1.com',
      cpf: '76684130810',
      card_status: true
    )

    create(
      :employee_profile,
      position:,
      department:,
      name: 'Func Quatro',
      social_name: 'Func Quatro',
      status: 'unblocked',
      email: 'funcionario4@empresa1.com',
      cpf: '99701348923',
      card_status: false
    )

    get_card_api_response = double(
      'faraday_response',
      status: 200,
      body: {
        id: 1,
        name: 'Name',
        number: '123456789',
        points: 1000,
        status: 'active'
      }.to_json
    )

    get_card_type_response = double(
      'faraday_response',
      status: 200,
      body: [{
        company_card_type_id: 1,
        name: 'Name',
        icon: nil,
        start_points: 100,
        conversion_tax: 1
      }].to_json
    )

    allow(Faraday).to receive(:get)
      .with('http://localhost:4000/api/v1/')
      .and_return(200)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/cards/#{manager.cpf}")
      .and_return(get_card_api_response)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/cards/#{employee1.cpf}")
      .and_return(get_card_api_response)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/cards/#{employee2.cpf}")
      .and_return(get_card_api_response)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/company_card_types?cnpj=#{company.registration_number}")
      .and_return(get_card_type_response)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/company_card_types?cnpj=#{company.registration_number}")
      .and_return(get_card_type_response)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/company_card_types?cnpj=#{company.registration_number}")
      .and_return(get_card_type_response)

    login_as manager_user
    visit new_company_recharge_history_path(company_id: company.id)
    click_on 'Recarregar todos os cartões'

    expect(page).to have_content 'Recarregar todos os cartões'
    expect(page).to have_content 'Confirmar'
    expect(page).to have_content 'Valor Padrão'
    expect(page).to have_content 'R$ 100,00'
    expect(page).to have_content '3 funcionários válidos'
    expect(page).to have_content 'Nome Gerente'
    expect(page).to have_content 'Func Um'
    expect(page).to have_content 'Func Dois'
    expect(page).to have_content 'manager@empresa1.com'
    expect(page).to have_content 'funcionario1@empresa1.com'
    expect(page).to have_content 'funcionario2@empresa1.com'
    expect(page).to_not have_content 'Func Tres'
    expect(page).to_not have_content 'Func Quatro'
    expect(page).to_not have_content 'funcionario3@empresa1.com'
    expect(page).to_not have_content 'funcionario4@empresa1.com'
  end

  scenario 'confirma a recarga e visualiza o histórico' do
    company = create(:company, domain: 'empresa1.com')
    department = create(:department, company:)
    position = create(:position, department:)
    create(:manager_emails, company:, email: 'manager@empresa1.com')
    manager_user = create(:manager_user, email: 'manager@empresa1.com', cpf: '69142235219')
    manager = create(
      :employee_profile,
      department:,
      position:,
      email: 'manager@empresa1.com',
      cpf: '69142235219',
      status: 'unblocked',
      user: manager_user,
      name: 'Nome Gerente',
      social_name: 'Nome Gerente',
      card_status: true
    )

    employee1 = create(
      :employee_profile,
      position:,
      department:,
      name: 'Func Um',
      social_name: 'Func Um',
      status: 'unblocked',
      email: 'funcionario1@empresa1.com',
      cpf: '15703243017',
      card_status: true
    )

    employee2 = create(
      :employee_profile,
      position:,
      department:,
      name: 'Func Dois',
      social_name: 'Func Dois',
      status: 'unblocked',
      email: 'funcionario2@empresa1.com',
      cpf: '29963810926',
      card_status: true
    )

    create(
      :employee_profile,
      position:,
      department:,
      name: 'Func Tres',
      social_name: 'Func Tres',
      status: 'fired',
      email: 'funcionario3@empresa1.com',
      cpf: '76684130810',
      card_status: true
    )

    create(
      :employee_profile,
      position:,
      department:,
      name: 'Func Quatro',
      social_name: 'Func Quatro',
      status: 'unblocked',
      email: 'funcionario4@empresa1.com',
      cpf: '99701348923',
      card_status: false
    )

    get_card_type_response = double(
      'faraday_response',
      status: 200,
      body: [{
        company_card_type_id: 1,
        name: 'Name',
        icon: nil,
        start_points: 100,
        conversion_tax: 1
      }].to_json
    )

    get_card_api_response = double(
      'faraday_response',
      status: 200,
      body: {
        id: 1,
        name: 'Name',
        number: '123456789',
        points: 1000,
        status: 'active'
      }.to_json
    )

    patch_recharge_api_response = double(
      'faraday_response',
      status: 200,
      body: [{
        message: 'Recarga efetuada com sucesso'
      }].to_json
    )

    request1 = { recharge: [{ value: 100.0, cpf: '69142235219' }] }
    request2 = { recharge: [{ value: 100.0, cpf: '15703243017' }] }
    request3 = { recharge: [{ value: 100.0, cpf: '29963810926' }] }

    allow(Faraday).to receive(:get)
      .with('http://localhost:4000/api/v1/')
      .and_return(200)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/company_card_types?cnpj=#{company.registration_number}")
      .and_return(get_card_type_response)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/company_card_types?cnpj=#{company.registration_number}")
      .and_return(get_card_type_response)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/company_card_types?cnpj=#{company.registration_number}")
      .and_return(get_card_type_response)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/cards/#{manager.cpf}")
      .and_return(get_card_api_response)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/cards/#{employee1.cpf}")
      .and_return(get_card_api_response)

    allow(Faraday).to receive(:get)
      .with("http://localhost:4000/api/v1/cards/#{employee2.cpf}")
      .and_return(get_card_api_response)

    allow(Faraday).to receive(:patch)
      .with('http://localhost:4000/api/v1/cards/recharge',
            request1.to_json,
            'Content-Type' => 'application/json')
      .and_return(patch_recharge_api_response)

    allow(Faraday).to receive(:patch)
      .with('http://localhost:4000/api/v1/cards/recharge',
            request2.to_json,
            'Content-Type' => 'application/json')
      .and_return(patch_recharge_api_response)

    allow(Faraday).to receive(:patch)
      .with('http://localhost:4000/api/v1/cards/recharge',
            request3.to_json,
            'Content-Type' => 'application/json')
      .and_return(patch_recharge_api_response)

    login_as manager_user
    visit new_company_multiple_recharge_path(company_id: company.id)
    click_on 'Confirmar'

    expect(page).to have_content '3 Recargas adicionadas ao histórico'
    expect(page).to have_content 'Atualize para visualizar histórico completo'
    expect(page).to have_content 'Histórico Geral de Recargas'
    expect(page).to have_content 'Valor'
    expect(page).to have_content 'R$ 100,00'
    expect(page).to have_content 'Funcionário'
    expect(page).to have_content 'Nome Gerente'
    expect(page).to have_content 'Func Um'
    expect(page).to have_content 'Func Dois'
    expect(page).to_not have_content 'Func Tres'
    expect(page).to_not have_content 'Func Quatro'
    expect(page).to have_content '691.422.352-19'
    expect(page).to have_content '157.032.430-17'
    expect(page).to have_content '299.638.109-26'
    expect(page).to_not have_content '766.841.308-10'
    expect(page).to_not have_content '997.013.489-23'
    expect(page).to have_content 'Responsável'
    expect(page).to have_content 'manager@empresa1.com'
    expect(page).to have_content I18n.l(RechargeHistory.last.created_at, format: :short)
  end
end
