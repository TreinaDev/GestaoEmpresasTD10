class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: t('.success')
    else
      flash.now[:notice] = 'Não foi possível atualizar dados da empresa'
      render :edit

    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:brand_name, :corporate_name,
                                    :registration_number, :address,
                                    :phone_number, :email, :domain, :logo)
  end
end
