class AdminController < ApplicationController
  before_action :authenticate_user!

  protected

  def require_admin
    return if current_user.admin?

    flash[:alert] = t('forbidden')
    redirect_to root_path
  end
end
