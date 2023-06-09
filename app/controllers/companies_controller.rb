class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @manager = Manager.new
    @emails = Manager.active.where(company: @company)
  end
end
