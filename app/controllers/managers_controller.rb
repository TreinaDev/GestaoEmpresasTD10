class ManagersController < ApplicationController
  def create
    @manager = Manager.new manager_params
    @manager.created_by_id = current_user.id
    @company = @manager.company

    if @manager.valid?
      redirect_to company_path(@company), notice: t('controllers.managers.create.success')
    else
      flash.now[:notice] = t('controllers.managers.create.failed')
      render 'companies/show'
    end
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.canceled!
    @company = @manager.company
    redirect_to company_path(@company), notice: t('controllers.managers.destroy.success')
  end

  private

  def manager_params
    params.require(:manager).permit(:email, :company_id)
  end
end
