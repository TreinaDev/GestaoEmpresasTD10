class ManagersController < ApplicationController
  before_action :set_company, only: [:create]

  def create
    @manager = Manager.new manager_params
    @manager.created_by_id = current_user.id
    if @manager.valid?
      redirect_to company_path(@company), notice: t('.success')
    else
      flash.now[:notice] = 'Não foi possível cadastrar email'
      render 'companies/show'
    end
  end

  private

  def set_company
    @company = Company.find(params[:manager][:company_id])
  end

  def manager_params
    params.require(:manager).permit(:email)
  end
end
