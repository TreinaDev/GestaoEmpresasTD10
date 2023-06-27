class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[show edit update]
  before_action :set_company, only: %i[index show new edit create update]
  before_action :require_manager, only: %i[new create edit update]
  before_action :manager_belongs_to_company?

  def index
    @departments = Department.where(company_id: params[:company_id])
  end

  def show; end

  def new
    @department = Department.new
  end

  def edit
    @department = @company.departments.find(params[:id])
  end

  def create
    @department = Department.new department_params
    @department.company = @company

    return redirect_to [@company, @department], notice: t('.success') if @department.save

    flash.now[:alert] = t('.error')
    render 'new'
  end

  def update
    return redirect_to [@company, @department], notice: t('.success') if @department.update(department_params)

    flash.now[:alert] = t('.error')
    render 'edit'
  end

  private

  def department_params
    params.require(:department).permit(:name, :description, :code, :company_id)
  end

  def set_department
    @department = Department.find(params[:id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
