class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?
  before_action :authenticate_user!

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

  def after_sign_in_path_for(resource)
    if current_user.manager? && !current_user.employee_profile
      manager = Manager.find_by(email: current_user.email)
      return redirect_to new_company_department_employee_profile_path(company_id: manager.company.id, department_id: 1), alert: 'Conclua seu cadastro para continuar.'
      # new_company_department_employee_profile_path(company_id: company.id, department_id: department.id)
    else
      super # chama a implementação original do Devise
    end
  end
end
