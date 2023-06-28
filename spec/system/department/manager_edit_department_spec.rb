require 'rails_helper'

feature 'Manager edita departamento' do
  scenario 'Com sucesso' do
    company = create(:company, brand_name: 'Apple')
    create(:manager_emails, company:)
    new_user = create(:manager_user)

    allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('AAA007')
    department = create(:department, company:, name: 'Compras')
    position = create(:position, department:)
    create(:employee_profile, :manager, position:, department:, user: new_user)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)

    login_as new_user
    visit company_department_path(company.id, department.id)
    within('div#options') do
      click_on 'Editar'
    end

    fill_in 'Nome',	with: 'Jurídico'
    fill_in 'Descrição',	with: 'O departamento jurídico'
    click_on 'Salvar'

    expect(page).to have_content 'Departamento atualizado com sucesso!'
    expect(page).to have_content 'Jurídico'
    expect(page).to have_content 'AAA007'
    expect(page).to have_content 'Apple'
  end

  scenario 'com dados incompletos' do
    company = create(:company, brand_name: 'Apple')
    create(:manager_emails, company:)
    new_user = create(:manager_user)
    department = create(:department, company:, name: 'Compras')
    position = create(:position, department:)
    create(:employee_profile, :manager, department:, user: new_user, position:)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as new_user
    visit company_department_path(company.id, department.id)
    within('div#options') do
      click_on 'Editar'
    end

    fill_in 'Nome',	with: 'Jurídico'
    fill_in 'Descrição',	with: ''
    click_on 'Salvar'

    expect(page).not_to have_content 'Departamento atualizado com sucesso!'
    expect(page).to have_content 'Não foi possível atualizar departamento!'
  end

  scenario 'e o botão de editar está bloqueado, pois é o derpartamento padrão de Recursos Humanos' do
    company = create(:company, brand_name: 'Apple')
    create(:manager_emails, company:)
    new_user = create(:manager_user)
    department = create(:department, company:)
    position = create(:position, department:)
    create(:employee_profile, :manager, department:, user: new_user, position:)

    json_data = Rails.root.join('spec/support/json/card_types.json').read
    fake_response = double('faraday_response', status: 200, body: json_data)
    cnpj = company.registration_number.tr('^0-9', '')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/company_card_types').and_return(fake_response)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}").and_return(fake_response)

    login_as new_user
    visit company_department_path(company.id, department.id)

    btn_edit = page.find('#btn_edit')

    expect(btn_edit[:class].split).to include('disabled')
  end
end
