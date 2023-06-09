class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cpf])
  end
end
