class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :profile_check, unless: :devise_controller?


  protected

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cpf])
  end

  def require_manager
    return if current_user.manager?

    flash[:alert] = t('forbidden')
    redirect_to root_path
  end

  def require_admin
    return if current_user.admin?

    flash[:alert] = t('forbidden')
    redirect_to root_path
  end

  def manager_belongs_to_company?
    company_id = params[:company_id]
    manager = Manager.find_by(email: current_user.email)

    return if manager.company_id == company_id.to_i

    redirect_to root_path, alert: t('forbidden')
  end

  def profile_check
    return if params[:controller] == "employee_profiles" && params[:action] == "new"
    if current_user && current_user.manager? && !current_user.employee_profile
      manager = Manager.find_by(email: current_user.email)
      if manager
        department = Department.where(name: 'Departamento de RH').where(company_id: manager.company_id).first
        redirect_to new_manager_company_department_employee_profiles_path(company_id: manager.company.id, department_id: department.id)
      end
    end
  end
end
