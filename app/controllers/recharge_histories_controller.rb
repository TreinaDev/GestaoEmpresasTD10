class RechargeHistoriesController < ApplicationController
  before_action :require_manager, except: :index
  before_action :manager_belongs_to_company?, except: :index
  before_action :set_employee_profile, only: %i[new create]
  before_action :validate_employee, only: %i[new create]
  before_action :authorized_employee, only: %i[index]

  def index
    return redirect_to search_companies_path, alert: t('.employee_not_found') if @employee.nil?

    @recharges = RechargeHistory.where(employee_profile_id: @employee.id).order(created_at: 'desc')
  end

  def new; end

  def create
    request = { recharge: [{ value: @value, cpf: @employee.cpf }] }
    response = PatchRechargeApi.new(request).send
    flash_message(response)
    create_recharge_history if @body.first['errors'].nil?

    redirect_to company_recharge_histories_path(@employee.department.company, params: { employee: @employee })
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
    return t('.invalid_value', value: @value) unless @value.to_f.positive?
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
    @history = RechargeHistory.new(
      value: params[:value],
      employee_profile: @employee,
      creator: current_user
    )
    @history.save
  end

  def authorized_employee
    return redirect_to root_path, alert: t('forbidden') if current_user.admin?

    @employee = EmployeeProfile.joins(:department)
                               .where(departments: { company_id: params[:company_id] })
                               .find_by(id: params[:employee])

    manager_belongs_to_company? if current_user.manager?

    redirect_to root_path, alert: t('forbidden') unless (current_user.id == @employee.user_id) || current_user.manager?
  end
end
