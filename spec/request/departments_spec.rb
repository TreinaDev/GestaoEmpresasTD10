require 'rails_helper'

RSpec.describe 'Departments', type: :request do
  describe 'POST /departments' do
    it 'admin tenta criar departamento' do
      admin = create(:user, email: 'user@punti.com')

      login_as admin

      post '/departments', params: {
        department: {
          name: 'A'
        }
      }

      follow_redirect!

      expect(response.body).to include 'Usuário sem permissão para executar essa ação'
    end
  end
end
