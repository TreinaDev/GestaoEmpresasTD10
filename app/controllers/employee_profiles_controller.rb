class EmployeeProfilesController < EmployeeCardApiController
  before_action :manager_belongs_to_company?
  before_action :company_is_active?, only: %i[new create]
  before_action :set_employee_profile_data, only: %i[create_manager]
  before_action :set_position_and_department_for_employee, only: %i[create_manager]
  # before_action :require_manager
  skip_before_action :profile_check

  def new_manager
    @employee_profile = EmployeeProfile.new
    @manager = ManagerEmails.find_by(email: current_user.email)
  end

  def create_manager
    return redirect_to root_path, notice: t('.success') if @employee_profile.save

    flash.now[:alert] = t('.failure')

    @manager = ManagerEmails.find_by(email: current_user.email)
    render :new_manager
  end

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

  def company_is_active?
    return false if @company.active

    redirect_to root_path, alert: t('inactive_company')
  end

  def set_employee_profile_data
    @employee_profile = EmployeeProfile.new(manager_profile_params)
    @employee_profile.user_id = current_user.id
    @employee_profile.email = current_user.email
    @employee_profile.cpf = current_user.cpf
  end

  def set_position_and_department_for_employee
    @employee_profile.department_id = @department.id
    @employee_profile.position = Position.where(name: 'Gerente').where(department_id: @department.id).first
  end

  def employee_profile_params
    params.require(:employee_profile).permit(:name, :social_name, :rg, :cpf, :email,
                                             :address, :birth_date, :phone_number,
                                             :admission_date, :dismissal_date, :marital_status,
                                             :status, :position_id, :user_id)
  end

  def manager_profile_params
    params.require(:employee_profile).permit(:name, :social_name, :rg, :cpf, :email,
                                             :address, :birth_date, :phone_number,
                                             :admission_date, :dismissal_date, :marital_status,
                                             :status, :user_id)
  end
end
