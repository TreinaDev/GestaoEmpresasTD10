class RechargeHistoriesController < ApplicationController
  before_action :require_manager
  before_action :manager_belongs_to_company?
  before_action :find_employee_and_validate_cpf, only: %i[new create]

  def new; end

  def create
    request = { recharge: [{ value: @value, cpf: @cpf }] }
    response = PatchRechargeApi.new(request).send
    body = JSON.parse(response.body)
    create_recharge_history if body.first['errors'].nil?

    flash_message(response)
    redirect_to new_company_recharge_history_path
  end

  private

  def find_employee_and_validate_cpf
    return if params[:cpf].blank?

    @cpf = params[:cpf].gsub(/\D/, '')
    @value = params[:value].to_f if params[:value].present?
    @employee = EmployeeProfile.find_by(cpf: @cpf)

    redirect_with_error(t('.cpf_not_found', cpf: params[:cpf])) if employee_not_found?
    redirect_with_error(t('.card_not_requested', cpf: params[:cpf])) if card_not_requested?
    redirect_with_error(t('.incorrect_status', status: t(".#{@employee.status}"))) if incorrect_status?
    redirect_with_error('Valor inválido') if invalid_value?
  end

  def employee_not_found?
    @employee.nil? || @employee.department.company.id.to_s != params[:company_id]
  end

  def card_not_requested?
    !@employee.card_status
  end

  def incorrect_status?
    !@employee.unblocked?
  end

  def invalid_value?
    params[:value].present? & !params[:value].to_f.positive?
  end

  def redirect_with_error(message)
    flash[:alert] = message
    redirect_to new_company_recharge_history_path
  end

  def flash_message(response)
    status = response.status
    body = JSON.parse(response.body)

    if body.first['errors'].present?
      flash[:alert] = body.first['errors']
    elsif status == 200
      flash[:notice] = body.first['message']
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
