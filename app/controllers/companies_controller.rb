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
    @company.save

    redirect_to @company, notice: t('.success')
  end
end
