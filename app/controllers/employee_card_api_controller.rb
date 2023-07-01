class EmployeeCardApiController < ApplicationController
  before_action :set_employee_profile,
                only: %i[edit update show deactivate_card activate_card new_fired fired]
  before_action :set_card, only: %i[show deactivate_card activate_card new_fired fired]
  before_action :set_department_and_company
  before_action :require_manager,
                only: %i[show edit update create_card deactivate_card new_fired fired new_manager create_manager new create]
  before_action :status_api, only: %i[show edit]

  def show
    get_card_with_logo(@employee_profile)
  end

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
