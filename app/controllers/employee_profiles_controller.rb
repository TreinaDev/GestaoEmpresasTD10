class EmployeeProfilesController < ApplicationController
  before_action :set_employee_profile, only: %i[show]
  before_action :set_department_and_company
  before_action :require_manager
  before_action :manager_belongs_to_company?

  def show; end

  def new
    @employee_profile = EmployeeProfile.new
  end

  def create
    @employee_profile = EmployeeProfile.new(employee_profile_params)
    @employee_profile.department_id = @department.id

    return redirect_to [@company, @department, @employee_profile], notice: t('.success') if @employee_profile.save

    flash.now[:alert] = t('.failure')
    render :new
  end

  private

  def set_employee_profile
    @employee_profile = EmployeeProfile.find(params[:id])
  end

  def set_department_and_company
    @department = Department.find_by(id: params[:department_id])
    @company = Company.find_by(id: params[:company_id])
  end

  def employee_profile_params
    params.require(:employee_profile).permit(:name, :social_name, :email, :cpf, :rg,
                                             :address, :birth_date, :phone_number,
                                             :admission_date, :dismissal_date, :marital_status,
                                             :status, :position_id, :user_id)
  end
end
