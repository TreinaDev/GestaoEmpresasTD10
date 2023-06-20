class ManagerEmailsController < ApplicationController
  before_action :set_new_manager_and_company, only: [:create]
  before_action :email_exists_canceled?, only: [:create]

  def create
    if @manager.save
      redirect_to company_path(@company), notice: t('controllers.managers.create.success')
    else
      @emails = ManagerEmails.active.where(company: @company)
      flash.now[:notice] = t('controllers.managers.create.failed')
      render 'companies/show', status: :unprocessable_entity
    end
  end

  def destroy
    @manager = ManagerEmails.find(params[:id])
    @company = @manager.company
    @manager.canceled!
    redirect_to company_path(@company), notice: t('controllers.managers.destroy.success')
  end

  private

  def set_new_manager_and_company
    @manager = ManagerEmails.new manager_params
    @manager.created_by_id = current_user.id
    @company = @manager.company
  end

  def email_exists_canceled?
    return unless @manager.email.present? && ManagerEmails.where(email: @manager.email).canceled.any?

    @manager.active!
    redirect_to company_path(@company),
                notice: t('controllers.managers.create.reactivated')
  end

  def manager_params
    params.require(:manager_emails).permit(:email, :company_id)
  end
end
