class RechargeHistoriesController < ApplicationController
  before_action :require_manager
  before_action :manager_belongs_to_company?
  before_action :set_employee_profile, only: %i[new create]
  before_action :validate_employee, only: %i[new create]

  def new; end

  def create
    request = { recharge: [{ value: params[:value].to_f, cpf: @employee.cpf }] }
    response = PatchRechargeApi.new(request).send
    flash_message(response)
    create_recharge_history if @body.first['errors'].nil?

    redirect_to recharge_history_company_department_employee_profile_path(@employee.department.company,
                                                                          @employee.department, @employee)
  end

  private

  def set_employee_profile
    @cpf = params[:cpf]&.gsub(/\D/, '')
    @employee = EmployeeProfile.joins(:department)
                               .where(departments: { company_id: params[:company_id] })
                               .find_by(cpf: @cpf)
  end

  def validate_employee
    return if params[:value].blank?

    @value = params[:value].to_f
    message = find_invalidities
    redirect_to new_company_recharge_history_path, alert: message if message
  end

  def find_invalidities
    return t('.cpf_not_found', cpf: @cpf) if @employee.nil?
    return t('.card_not_requested', cpf: @cpf) unless @employee.card_status
    return t('.incorrect_status', status: t(".#{@employee.status}")) unless @employee.unblocked?
    return t('.invalid_value', value: params[:value]) unless params[:value].to_f.positive?
  end

  def flash_message(response)
    status = response.status
    @body = JSON.parse(response.body)

    if @body.first['errors'].present?
      flash[:alert] = @body.first['errors']
    elsif status == 200
      flash[:notice] = @body.first['message']
    end
  end

  def create_recharge_history
    historico = RechargeHistory.new(
      value: params[:value],
      employee_profile: @employee,
      creator: current_user,
      recharge_date: Time.zone.today
    )
    historico.save
  end
end
