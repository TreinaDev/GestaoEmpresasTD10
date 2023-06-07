class ManagersController < ApplicationController
  def create
    company = Company.find(params[:manager][:company_id])
    @manager = Manager.new(params[:email])
    @manager.created_by_id = current_user.id
    if @manager.save
      redirect_to company_path(company), notice: 'Email cadastrado com sucesso'
    else
      redirect_to company_path(company), notice: 'Não é possível cadastrar email'
    end      
  end
end
