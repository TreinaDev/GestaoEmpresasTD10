class EmployeeProfilesController < ApplicationController
  before_action :set_employee_profile, only: %i[show]
  before_action :set_departments, :set_positions, only: %i[new create]

  def show; end

  def new
    @employee_profile = EmployeeProfile.new
  end

  def create
    @employee_profile = EmployeeProfile.new(employee_profile_params)

    return redirect_to @employee_profile, notice: t('.success') if @employee_profile.save

    flash.now[:alert] = t('.failure')
    render :new
  end

  private

  def set_employee_profile
    @employee_profile = EmployeeProfile.find(params[:id])
  end

  def set_departments
    @departments = Department.all
  end

  def set_positions
    @positions = Position.all
  end

  def employee_profile_params
    params.require(:employee_profile).permit(:name, :social_name, :email, :cpf, :rg,
                                             :address, :birth_date, :phone_number,
                                             :admission_date, :dismissal_date, :marital_status,
                                             :status, :department_id, :position_id, :user_id)
  end
end
