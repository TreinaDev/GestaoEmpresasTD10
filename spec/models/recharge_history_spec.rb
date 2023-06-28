require 'rails_helper'

RSpec.describe RechargeHistory, type: :model do
  describe 'validações' do
    it 'value deve ser obrigatório' do
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
      recharge = RechargeHistory.new(value: nil, recharge_date: Date.today, employee_profile: employee)

      expect(recharge.valid?).to eq false
    end

    it 'recharge_date deve ser obrigatório' do
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
      recharge = RechargeHistory.new(value: 100.00, recharge_date: nil, employee_profile: employee)

      expect(recharge.valid?).to eq false
    end
  end
end
