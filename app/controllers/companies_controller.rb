class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    company_params = params.require(:company).permit(:brand_name, :corporate_name,
                                                     :registration_number, :address,
                                                     :phone_number, :email, :domain, :logo)
    @company = Company.new company_params

    return redirect_to @company, notice: t('.success') if @company.save

    flash.now[:alert] = t('.failure')
    render :new
  end
end
