class UsersController < ApplicationController
  before_action :require_admin, except: :profile
  before_action :find_user, only: %i[block unblock]

  def index; end

  def profile
    return redirect_to root_path, alert: t('forbidden') if current_user.admin?

    @employee_profile = EmployeeProfile.find_by(email: current_user.email)
    @card = GetCardApi.show(@employee_profile.cpf)
  end

  def block
    if @user.block!
      redirect_to manager_company_path(@company), alert: t('success.user.blocked')
    else
      redirect_to manager_company_path(@company), alert: t('errors.user.blocked_fail')
    end
  end

  def unblock
    if @user.unblock!
      redirect_to manager_company_path(@company), notice: t('success.user.unblocked')
    else
      redirect_to manager_company_path(@company), alert: t('errors.user.unblocked_fail')
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
    @company = @user.employee_profile.department.company
  end
end
