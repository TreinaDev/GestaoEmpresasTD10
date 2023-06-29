require 'rails_helper'

feature 'visitante acessa página de perfil' do
  scenario 'com sucesso' do
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)

    employee_data = create(:employee_profile, :employee, department:, position:, email: 'funcionario@empresa.com',
                                                         cpf: '69142235219', card_status: true)

    employee_user = User.create!(email: employee_data.email, cpf: employee_data.cpf, password: '123456')

    json_data = Rails.root.join('spec/support/json/cards.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/cards/#{employee_user.cpf}").and_return(fake_response)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as employee_user

    visit profile_users_path

    expect(page).to have_content('Roberto Carlos Nascimento')
    expect(page).to have_content('Nome Social: Roberto Carlos')
    expect(page).to have_content('E-mail: funcionario@empresa.com')
    expect(page).to have_content('Data de Nascimento: 06/06/2023')
    expect(page).to have_content('CPF: 691.422.352-19')
    expect(page).to have_content('RG: 12345678901')
    expect(page).to have_content('Telefone: 1199776655')
    expect(page).to have_content('Endereço: Rua do funcionário, 1200')
    expect(page).to have_content('Estado Civil: Solteiro(a)')
    expect(page).to have_content('Data de Admissão: 06/06/2023')
    expect(page).to have_content("Departamento: #{department.name}")
    expect(page).to have_content("Cargo: #{position.name}")
    within('div#user_card') do
      expect(page).to have_content('Cartão Gold')
      expect(page).to have_content('Número do cartão: 1234560987')
      expect(page).to have_content('Pontos: 100')
      expect(page).to have_content('Status: Ativo')
    end
  end

  scenario 'Api está offline e não exibe informações do cartão' do
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)
    employee_data = create(:employee_profile, :employee, position:, department:, card_status: true)
    employee_user = User.create!(
      email: employee_data.email,
      cpf: employee_data.cpf,
      password: '123456'
    )

    json_data = '{}'
    fake_status = double('faraday_status', status: 500, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/cards/#{employee_user.cpf}").and_return(fake_status)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as employee_user

    visit profile_users_path

    within('div#user_card') do
      expect(page).to have_content 'Sistema indisponível no momento, por favor tente mais tarde'
      expect(page).to_not have_content('Cartão Gold')
      expect(page).to_not have_content('Número do cartão: 1234560987')
      expect(page).to_not have_content('Pontos: 100')
      expect(page).to_not have_content('Status: Ativo')
    end
  end

  scenario 'e vê que ainda não possui cartão' do
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)
    employee_data = create(:employee_profile, :employee, position:, department:, card_status: false)
    employee_user = User.create!(
      email: employee_data.email,
      cpf: employee_data.cpf,
      password: '123456'
    )

    json_data = '{}'
    fake_status = double('faraday_status', status: 500, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/cards/#{employee_user.cpf}").and_return(fake_status)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as employee_user

    visit profile_users_path

    within('div#user_card') do
      expect(page).to have_content 'Você não possui cartão, fale com o setor de RH'
    end
  end
end
