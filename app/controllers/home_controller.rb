class HomeController < ApplicationController
  before_action :is_manager_without_profile

  def index; end

  private

  def is_manager_without_profile
    if current_user.manager? && !current_user.employee_profile
      manager = Manager.find_by(email: current_user.email)
      return redirect_to new_company_department_employee_profile_path(company_id: manager.company.id, department_id: 1), alert: 'Conclua seu cadastro para continuar.'
    end
  end
end
