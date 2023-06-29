class RechargeHistoriesController < ApplicationController
  before_action :require_manager
  before_action :manager_belongs_to_company?
  before_action :find_employee_and_validate_cpf, only: %i[new create]

  def new; end

  def create
    request = { recharge: [{ value: @value, cpf: @cpf }] }
    response = PatchRechargeApi.new(request).send
    create_recharge_history if response.status == 200

    flash_message(response)
    redirect_to new_company_recharge_history_path
  end

  private

  def find_employee_and_validate_cpf
    return if params[:cpf].blank?

    @cpf = params[:cpf].gsub(/\D/, '')
    @value = params[:value].to_f if params[:value].present?
    @employee = EmployeeProfile.find_by(cpf: @cpf)
    if @employee.nil? || @employee.department.company.id.to_s != params[:company_id]
      flash[:alert] = I18n.t('recharge_histories.cpf_not_found', cpf: params[:cpf])
      redirect_to new_company_recharge_history_path
    elsif !@employee.card_status
      flash[:alert] = I18n.t('recharge_histories.card_not_requested', cpf: params[:cpf])
      redirect_to new_company_recharge_history_path
    elsif !@employee.unblocked?
      flash[:alert] = I18n.t('recharge_histories.incorrect_status', status: t(".#{@employee.status}"))
      redirect_to new_company_recharge_history_path
    elsif !params[:value].to_f.positive?
      flash[:alert] = 'Valor inválido'
      redirect_to new_company_recharge_history_path
    end
  end

  def flash_message(response)
    status = response.status
    body = JSON.parse(response.body) unless status == 500

    if status == 500
      flash[:alert] = t('.failure_response')
    elsif status == 200
      flash[:notice] = body.first['message']
    else
      flash[:alert] = body['errors'] || t('.unknown_error')
    end
  end

  def create_recharge_history
    historico = RechargeHistory.new(
      value: params[:value],
      employee_profile: @employee,
      creator: current_user,
      recharge_date: Date.today
    )
    historico.save
  end
end
