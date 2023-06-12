class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update activate deactivate]
  before_action :authenticate_admin!, only: %i[index inactives new create edit update activate deactivate]

  def index
    @active_companies = Company.where(status: true)
  end

  def inactives
    @inactive_companies = Company.where(status: false)
  end

  def show; end

  def new
    @company = Company.new
  end

  def edit; end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to @company, notice: t('.success')
    else
      flash.now[:notice] = 'Empresa não cadastrada'
      render :new
    end
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: t('.success')
    else
      flash.now[:notice] = 'Não foi possível atualizar dados da empresa'
      render :edit
    end
  end

  def activate
    @company.update(status: true)
    redirect_to company_path(@company)
  end

  def deactivate
    @company.update(status: false)
    redirect_to company_path(@company)
  end

  private

  def authenticate_admin!
    return if current_user&.role == 'admin'

    render plain: t('.warning'), status: :forbidden
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:brand_name, :corporate_name,
                                    :registration_number, :address,
                                    :phone_number, :email, :domain, :logo)
  end
end
