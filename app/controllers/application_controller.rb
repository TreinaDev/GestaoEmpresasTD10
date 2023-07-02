class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :profile_check, unless: :devise_controller?
  rescue_from Faraday::ConnectionFailed, with: :external_server_error

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
    return false unless current_user.manager?

    company_id = params[:company_id]
    manager = ManagerEmails.find_by(email: current_user.email)
    return false if manager.company_id == company_id.to_i

    redirect_to root_path, alert: t('forbidden')
  end

  def profile_check
    return unless current_user.manager? && !current_user.employee_profile

    redirect_to_finish_register
  end

  def redirect_to_finish_register
    manager = ManagerEmails.find_by(email: current_user.email)

    department = Department.where(name: 'Departamento de RH').where(company_id: manager.company_id).first
    redirect_to new_manager_company_department_employee_profiles_path(company_id: manager.company.id,
                                                                      department_id: department.id)
  end

  def external_server_error
    redirect_to root_path, alert: t('api_down')
  end

  def status_api
    redirect_to root_path, alert: t('api_down') if GetCardType.status == 500
  end

  def get_card_with_logo(employee)
    @card = GetCardApi.show(employee.cpf)
    @card_icon = GetCardType.find(employee.position.card_type_id, employee.department.company.registration_number)&.icon
  end
end
