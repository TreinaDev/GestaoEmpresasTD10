class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_department, only: %i[show edit update]
  before_action :manager?, only: %i[new create edit update]

  def show; end

  def new
    @companies = Company.all
    @department = Department.new
  end

  def edit
    @companies = Company.all
  end

  def create
    @department = Department.new department_params

    return redirect_to @department, notice: t('.success') if @department.save

    @companies = Company.all

    flash.now[:alert] = t('.error')
    render 'new'
  end

  def update
    return redirect_to @department, notice: t('.success') if @department.update(department_params)

    @companies = Company.all
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

  def manager?
    return redirect_to root_path, alert: t('forbidden') unless current_user.manager?
  end
end
