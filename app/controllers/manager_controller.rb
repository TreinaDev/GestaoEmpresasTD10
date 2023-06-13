class ManagerController < ApplicationController
  before_action :authenticate_user!
  before_action :require_manager

  protected

  def require_manager
    return if current_user.manager?

    flash[:alert] = t('forbidden')
    redirect_to root_path
  end
end
