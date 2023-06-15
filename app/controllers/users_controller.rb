class UsersController < ApplicationController
  before_action :find_user, only: %i[block unblock]
  before_action :require_admin

  def index
    @users = User.where(role: 'manager')
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
end
