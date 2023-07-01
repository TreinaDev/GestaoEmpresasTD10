class MultipleRechargesController < ApplicationController
  before_action :require_manager
  before_action :manager_belongs_to_company?
  before_action :set_valid_employees

  def index
    if session[:recent_recharge_ids]
      @recharge_history = RechargeHistory.where(id: session[:recent_recharge_ids]).order(created_at: 'desc')
      session.delete(:recent_recharge_ids)
    else
      @recharge_history = RechargeHistory.by_company(params[:company_id])
    end
  end

  def new; end

  def create
    return redirect_to root_path, alert: 'Nenhum funcionário válido para recarga' if @valid_employees.empty?

    @count = 0
    @valid_employees.each do |valid_employee|
      request = { recharge: [{ value: valid_employee.value, cpf: valid_employee.cpf }] }
      body = JSON.parse(PatchRechargeApi.new(request).send.body)
      register_recharges(valid_employee) if body.first['errors'].nil?
    end

    redirect_to company_multiple_recharges_path, notice: "#{@count} Recargas adicionadas ao histórico"
  end

  private

  def register_recharges(valid_employee)
    history = RechargeHistory.new(value: valid_employee.value, employee_profile: valid_employee, creator: current_user)
    if history.save
      session[:recent_recharge_ids] ||= []
      session[:recent_recharge_ids] << history.id
      @count += 1
    else
      flash[:alert] = 'Contate um Admin. Erro ao salvar histórico de recarga'
    end
  end

  def set_valid_employees
    @valid_employees = EmployeeProfile.joins(:department)
                                      .where(departments: { company_id: params[:company_id] })
                                      .where(card_status: true).where(status: :unblocked)
  end

end
