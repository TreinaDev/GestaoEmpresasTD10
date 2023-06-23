class EmployeeProfilesController < ApplicationController
  before_action :set_employee_profile, only: %i[show edit update new_fired fired]
  before_action :set_department_and_company
  before_action :require_manager
  before_action :manager_belongs_to_company?
  before_action :company_is_active?, only: %i[new create]

  def show; end

  def new
    @employee_profile = EmployeeProfile.new
  end

  def edit; end

  def create
    @employee_profile = EmployeeProfile.new(employee_profile_params)
    @employee_profile.department_id = @department.id

    return redirect_to [@company, @department, @employee_profile], notice: t('.success') if @employee_profile.save

    flash.now[:alert] = t('.failure')
    render :new
  end

  def create_card
    response = AppCardApi.new(params[:card]).send
    return redirect_to [@company, @department], notice: t('.unavailable') if response == 500

    @employee_profile = EmployeeProfile.find_by(cpf: params[:card]['cpf'])
    case response.status
    when 201
      redirect_to [@company, @department], notice: t('.success') if @employee_profile.update(card_status: true)
    else
      redirect_to [@company, @department], notice: t('.failure')
    end
  end

  def update
    if @employee_profile.update(employee_profile_params)
      return redirect_to [@company, @department, @employee_profile],
                         notice: t('.success')
    end

    flash.now[:alert] = t('.failure')
    render :new
  end

  def new_fired; end

  def fired
    if @employee_profile.fired?
      return redirect_to [@company, @department, @employee_profile],
                         alert: t('.already_fired')
    end

    @employee_profile.dismissal_date = params['fired']['date']
    @employee_profile.status = 'fired'
    return redirect_to [@company, @department, @employee_profile] if @employee_profile.save

    flash.now[:alert] = t('.failure')
    render 'new_fired'
  end

  private

  def company_is_active?
    company = Company.find(params[:company_id])
    return if company.active

    redirect_to root_path, alert: t('inactive_company')
  end

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
