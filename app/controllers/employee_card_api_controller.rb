class EmployeeCardApiController < ApplicationController
  before_action :set_employee_profile,
                only: %i[edit update show deactivate_card activate_card new_fired fired recharge_history]
  before_action :set_card, only: %i[show deactivate_card activate_card new_fired fired]
  before_action :set_department_and_company
  before_action :require_manager

  def show; end

  def edit; end

  def update
    if @employee_profile.update(employee_profile_params)
      return redirect_to [@company, @department, @employee_profile],
                         notice: t('.success')
    end

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

  def deactivate_card
    response = GetCardApi.deactivate(@card.id)

    return redirect_to [@company, @department], notice: t('.unavailable') if response == 500

    case response
    when 200
      redirect_to [@company, @department, @employee_profile], notice: t('.success')
    else
      redirect_to [@company, @department, @employee_profile], notice: t('.failure')
    end
  end

  def activate_card
    response = GetCardApi.activate(@card.id)

    return redirect_to [@company, @department], notice: t('.unavailable') if response == 500

    case response
    when 200
      redirect_to [@company, @department, @employee_profile], notice: t('.success')
    else
      redirect_to [@company, @department, @employee_profile], notice: t('.failure')
    end
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

  def recharge_history
    unless @employee_profile.card_status
      return redirect_to [@company, @department, @employee_profile],
                         notice: t('.no_card')
    end

    @recharges = RechargeHistory.where(employee_profile_id: @employee_profile.id)
  end

  private

  def set_employee_profile
    @employee_profile = EmployeeProfile.find(params[:id])
  end

  def set_card
    @card = GetCardApi.show(@employee_profile.cpf) unless @card == 500
  end

  def set_department_and_company
    @department = Department.find_by(id: params[:department_id])
    @company = Company.find_by(id: params[:company_id])
  end
end
