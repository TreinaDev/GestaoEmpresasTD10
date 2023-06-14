require 'rails_helper'

describe "Teste endpoint" do
  it "Retorna os nomes dos cartões disponíveis" do
    json_data = File.read(Rails.root.join('spec/support/json/card_types.json'))
    # fake_response = double("faraday_response", status: 200, body: json_data)
    # cnpj_empresa = create(:company).registration_number
    # allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj_empresa}").and_return(fake_response)

    # company = FactoryBot.create(:company)
    # department = FactoryBot.create(:department, company:)
    # admin_user = FactoryBot.create(:admin_user)
    # FactoryBot.create(:manager, created_by: admin_user)
    # manager_user = FactoryBot.create(:manager_user)

    # login_as(manager_user)
    # visit new_position_path

    puts JSON.parse(json_data).fetch(0)["name"]

    # expect(page).to have_content 'Cartão Básico'
    # expect(page).to have_content 'Cartão Intermediário'
    # expect(page).to have_content 'Cartão Avançado'
  end

end
