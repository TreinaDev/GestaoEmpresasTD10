class RechargeHistoriesController < ApplicationController
  before_action :require_manager
  before_action :manager_belongs_to_company?
  before_action :find_employee_and_validate_cpf, only: [:create]

  def new; end

  def create
    request = { recharge: [{ value: params[:value].to_i, cpf: params[:cpf] }] }

    response = PatchRechargeApi.new(request).send
    create_recharge_history if response.status == 200

    handle_response(response)
    render :new
  end

  private

  def find_employee_and_validate_cpf
    @employee = EmployeeProfile.find_by(cpf: params[:cpf])

    if @employee.nil? || @employee.department.company.id.to_s != params[:company_id]
      flash[:alert] = I18n.t('recharge_histories.cpf_not_found', cpf: params[:cpf])
      redirect_to new_company_recharge_history_path
    elsif !@employee.card_status
      flash[:alert] = I18n.t('recharge_histories.card_not_requested', cpf: params[:cpf])
      redirect_to new_company_recharge_history_path
    elsif !@employee.unblocked?
      flash[:alert] = I18n.t('recharge_histories.incorrect_status', status: t(".#{@employee.status}"))
      redirect_to new_company_recharge_history_path
    end
  end

  def handle_response(response)
    status = response.status
    body = JSON.parse(response.body) unless status == 500

    if status == 500
      flash.now[:alert] = t('.failure_response')
    elsif status == 200
      flash.now[:notice] = body.first['message']
    else
      flash.now[:alert] = body['errors'] || t('.unknown_error')
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
