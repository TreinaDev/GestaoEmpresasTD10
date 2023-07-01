require 'rails_helper'

describe 'Usuário vê histórico de recargas' do
  context 'como manager' do
    it 'com sucesso' do
      company = create(:company)
      department = create(:department, company:)
      admin_user = create(:admin_user)
      create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
      manager_user = create(:manager_user, email: "nome@#{company.domain}")
      position = create(:position, department:)
      create(:employee_profile, :manager, department:, position:, user: manager_user, name: 'arthur arthur',
                                          social_name: 'arthur arthur')
      employee = create(:employee_profile, position:, department_id: position.department.id,
                                           status: 'unblocked', email: "funcionario@#{company.domain}",
                                           cpf: '90900938005',
                                           card_status: true)

      login_as manager_user

      get company_recharge_histories_path(company.id, employee: employee.id)

      expect(response).to have_http_status 200
    end
  end
  context 'como funcionário' do
    it 'com sucesso' do
      company = create(:company)
      department = create(:department, company:)
      admin_user = create(:admin_user)
      create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
      manager_user = create(:manager_user, email: "nome@#{company.domain}")

      position = create(:position, department:)
      create(:employee_profile, :manager, department:, position:, user: manager_user, name: 'arthur arthur',
                                          social_name: 'arthur arthur')

      employee = create(:employee_profile, position:, department_id: position.department.id,
                                           status: 'unblocked', email: "funcionario1@#{company.domain}",
                                           cpf: '44047449865',
                                           card_status: true)

      user = create(:employee_user, email: "funcionario1@#{company.domain}", cpf: '44047449865')

      login_as user

      get company_recharge_histories_path(company.id, employee: employee.id)

      expect(response).to have_http_status 200
    end
    it 'e falha ao tentar ver histórico de outro funcionário' do
      company = create(:company)
      department = create(:department, company:)
      admin_user = create(:admin_user)
      create(:manager_emails, created_by: admin_user, company:, email: "nome@#{company.domain}")
      manager_user = create(:manager_user, email: "nome@#{company.domain}")
      position = create(:position, department:)
      manager_profile = create(:employee_profile, :manager, department:, position:, user: manager_user,
                                                            name: 'arthur arthur',
                                                            social_name: 'arthur arthur')

      create(:employee_profile, position:, department_id: position.department.id,
                                status: 'unblocked', email: "funcionario1@#{company.domain}",
                                cpf: '44047449865',
                                card_status: true)

      user = create(:employee_user, email: "funcionario1@#{company.domain}", cpf: '44047449865')

      login_as user

      get company_recharge_histories_path(company.id, employee: manager_profile.id)

      expect(response).to have_http_status 302
      expect(response).to redirect_to root_path
    end
  end
end
