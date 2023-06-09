class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?

  protected
  
  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cpf])
  end

  def authorize_admin
    if current_user == nil
      redirect_to root_path, alert: "Permissão negada"
    elsif current_user.role != "admin"
      redirect_to root_path, alert: "Permissão negada"
    end
  end
end
