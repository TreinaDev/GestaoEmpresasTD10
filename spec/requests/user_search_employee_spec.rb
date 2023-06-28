require 'rails_helper'

describe "user não consegue acessar rota de search" do
  it "como admin" do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    create(:manager_user)
    department = create(:department, company_id: company.id)
    create(:position, department_id: department.id)

    login_as admin
    get search_companies_path

    expect(response).to have_http_status 302
    expect(response).to redirect_to root_path
  end

  it "como funcionário" do
    admin = create(:admin_user)
    company = create(:company)
    create(:manager_emails, created_by: admin, company:)
    create(:manager_user)
    department = create(:department, company_id: company.id)
    create(:position, department_id: department.id)
    create(:employee_profile, :employee, cpf: '40690463804', department:)
    employee = create(:employee_user, cpf: '40690463804')

    login_as employee
    get search_companies_path

    follow_redirect!

    expect(response).to have_http_status 302
    expect(response).to redirect_to company_path(company)
  end
end