class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?

  def authorize_admin!
    redirect_to root_path, notice: t('controllers.managers.create.not_authorized') unless
    user_signed_in? && current_user.admin?
  end

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cpf])
  end
end
