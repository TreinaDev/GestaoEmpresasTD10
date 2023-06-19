class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?

  protected

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cpf])
  end

  def authorize_admin!
    return unless current_user.nil? || !current_user.admin?

    redirect_to root_path, alert: t('errors.user.permission_denied')
  end

  def manager?
    return redirect_to root_path, alert: t('forbidden') unless current_user.manager?
  end
end
