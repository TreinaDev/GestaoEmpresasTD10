require 'get_card_type'

class PositionsController < ApplicationController
  before_action :require_manager
  before_action :status_api
  before_action :set_company_and_department, only: %i[index show new edit create update]
  before_action :set_position, only: %i[show edit update]
  before_action :set_card_types, only: %i[show new edit create update]

  def index
    @positions = Position.where(department_id: params[:department_id])
  end

  def show; end

  def new
    @position = Position.new
  end

  def edit; end

  def create
    @position = Position.new(position_params.merge(department: @department))

    return redirect_to [@company, @department, @position], notice: t('.success') if @position.save

    flash.now[:alert] = t('.failure')
    render :new
  end

  def update
    return redirect_to [@company, @department, @position], notice: t('.success') if @position.update(position_params)

    flash.now[:alert] = t('.failure')
    render :edit
  end

  private

  def set_position
    @position = Position.find(params[:id])
    @card_type = GetCardType.find(@position.card_type_id, @company.registration_number)

    can_access_position
  end

  def set_company_and_department
    @company = Company.find(params[:company_id])
    @department = @company.departments.find(params[:department_id])
  end

  def set_card_types
    @card_types = GetCardType.all(@company.registration_number)
  end

  def position_params
    params.require(:position).permit(:name, :description, :card_type_id, :standard_recharge)
  end

  def can_access_position
    return if current_user.employee_profile.company.id == @position.company.id

    flash[:alert] = t('forbidden')
    redirect_to root_path
  end
end
