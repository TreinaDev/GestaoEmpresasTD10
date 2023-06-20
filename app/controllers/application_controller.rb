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

  def company_is_active?
    company = Company.find(params[:company_id])
    return if company.active

    redirect_to root_path, alert: t('forbidden')
  end
end
