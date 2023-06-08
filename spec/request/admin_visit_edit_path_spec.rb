require 'rails_helper'

describe 'Admin visita tela de edição', type: :request do
  it 'com sucesso' do
    admin = User.create!(email: 'manoel@punti.com', role: :admin, password: '123456')
    company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                          registration_number: '12.345.678/0001-95',
                          address: 'Rua California, 3000', phone_number: '11 99999-9999',
                          email: 'company@apple.com',
                          domain: 'apple.com', status: true)
    company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                        filename: 'logo.png', content_type: 'logo.png')
    company.save!

    login_as admin
    get "/companies/#{company.id}/edit"

    expect(response).to have_http_status(:ok)
  end
end
