class CompaniesController < ApplicationController
  before_action :require_admin, except: %i[show]
  before_action :set_company, only: %i[show edit update activate deactivate]

  def index
  end

  def show
    @company = Company.find(params[:id])
    @manager = ManagerEmails.new
    used_emails = User.manager.all.pluck('email')
    @emails = ManagerEmails.active.where(company: @company).where.not(email: used_emails)
  end

  def new
    @company = Company.new
  end

  def edit; end

  def create
    @company = Company.new company_params

    if @company.save
      department = @company.departments.create!(name: 'Departamento de RH', description: 'Recursos Humanos')
      department.positions.create!(name: 'Gerente', description: 'Gerente Geral')

      return redirect_to @company, notice: t('.success')
    end

    flash.now[:alert] = t('.failure')
    render :new
  end

  def inactives
    @inactive_companies = Company.where(active: false)
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
    @company.update(active: true)
    redirect_to company_path(@company)
  end

  def deactivate
    @company.update(active: false)
    redirect_to company_path(@company)
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
