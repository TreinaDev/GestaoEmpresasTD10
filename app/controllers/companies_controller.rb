class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @manager = Manager.new
    used_emails = User.manager.all.pluck('email')
    @emails = Manager.active.where(company: @company).where.not(email: used_emails)
  end
end
