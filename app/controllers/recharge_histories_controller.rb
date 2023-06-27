class RechargeHistoriesController < ApplicationController
  before_action :require_manager
  before_action :find_employee_and_validate_cpf, only: [:create]
  # before_action manager belongs to company

  def new; end

  def create
    request = { recharge: [{ value: params[:value].to_i, cpf: params[:cpf] }] }

    response = PatchRechargeApi.new(request).send
    handle_response(response)

    render :new
  end

  private

  def find_employee_and_validate_cpf
    @employee = EmployeeProfile.find_by(cpf: params[:cpf])

    if @employee.nil? || @employee.department.company.id.to_s != params[:company_id]
      flash[:alert] = "CPF não encontrado: #{params[:cpf]}"
      redirect_to new_recharge_history_path
    end
  end

  def handle_response(response)
    status = response[:status]
    body = response[:body]
  
    if status == 500
      flash.now[:alert] = 'ERRO de conexão'
    elsif status == 200
      create_recharge_history
      flash.now[:notice] = body['message'] || 'SUCESSO'
    else
      flash.now[:alert] = body['errors'] || 'ERRO desconhecido'
    end
  end
  

  def create_recharge_history
    historico = RechargeHistory.new(
      value: params[:value],
      employee_profile: @employee,
      created_by_id: current_user.id,
      recharge_date: Date.today
    )
    historico.save
  end
end
