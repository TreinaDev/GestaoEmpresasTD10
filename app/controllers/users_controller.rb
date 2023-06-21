class UsersController < ApplicationController
  before_action :require_admin, except: :profile
  before_action :find_user, only: %i[block unblock]
  before_action :verify_user, only: %i[profile]

  def index
    @users = User.manager
  end

  def profile
    @employee_profile = EmployeeProfile.find_by(email: current_user.email)
    @card = GetCardApi.show(@employee_profile.cpf)
  end

  def block
    if @user.block!
      redirect_to users_path, alert: t('success.user.blocked')
    else
      redirect_to users_path, alert: t('errors.user.blocked_fail')
    end
  end

  def unblock
    if @user.unblock!
      redirect_to users_path, notice: t('success.user.unblocked')
    else
      redirect_to users_path, alert: t('errors.user.unblocked_fail')
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def verify_user
    @employee_profile = EmployeeProfile.find_by(email: current_user.email)
    redirect_to root_path, notice: t('.not_current_user') if current_user.email? != @employee_profile.email?
    @employee_profile
  end
end
