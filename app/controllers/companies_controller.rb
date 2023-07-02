class CompaniesController < ApplicationController
  before_action :require_admin, except: %i[show search]
  before_action :set_company, only: %i[show edit update activate deactivate manager]
  before_action :require_manager, only: %i[search]

  def index; end

  def show; end

  def manager
    @users = User.manager.joins(employee_profile: { department: :company }).where(companies: { id: @company.id })
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
      department.positions.create!(name: 'Gerente', description: 'Gerente Geral', card_type_id: 1)

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
      flash.now[:notice] = t('.failure')
      render :edit
    end
  end

  def activate
    @company.active_employee if @company.update(active: true)
    redirect_to company_path(@company)
  end

  def deactivate
    @company.block_employee if @company.update(active: false)

    redirect_to company_path(@company)
  end

  def search
    company_id = current_user.department.company.id
    search_term = "%#{params[:search]}%"

    @employee_profiles = EmployeeProfile.joins(:department)
                                        .where(departments: { company_id: })
                                        .where('cpf LIKE :search OR employee_profiles.name LIKE
                                        :search', search: search_term)
  end

  private

  def set_company
    @company = Company.find(params[:id])

    return if current_user.admin?
    return if current_user.employee_profile.company.id == @company.id

    flash[:alert] = t('forbidden')
    redirect_to root_path
  end

  def company_params
    params.require(:company).permit(:brand_name, :corporate_name,
                                    :registration_number, :address,
                                    :phone_number, :email, :domain, :logo)
  end
end
