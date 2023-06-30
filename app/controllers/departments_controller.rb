class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[show edit update]
  before_action :set_company, only: %i[index show new edit create update]
  before_action :require_manager, only: %i[new create edit update]
  before_action :manager_belongs_to_company?
  before_action :status_api, only: %i[show]

  def index
    @departments = Department.where(company_id: params[:company_id])
  end

  def show
    find_by_positions
  end

  def new
    @department = Department.new
  end

  def edit
    @department = @company.departments.find(params[:id])
    return unless @department.name == 'Departamento de RH'

    redirect_to root_path, alert: t('.error')
  end

  def create
    @department = Department.new department_params
    @department.company = @company

    return redirect_to [@company, @department], notice: t('.success') if @department.save

    flash.now[:alert] = t('.error')
    render 'new'
  end

  def update
    return redirect_to [@company, @department], notice: t('.success') if @department.update(department_params)

    flash.now[:alert] = t('.error')
    render 'edit'
  end

  private

  def department_params
    params.require(:department).permit(:name, :description, :code, :company_id)
  end

  def set_department
    @department = Department.find(params[:id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def find_by_positions
    @position_cards = []

    @department.positions.each do |position|
      card = GetCardType.find(position.card_type_id, @company.registration_number)
      @position_cards[position.id] = if card
                                       [card.name, card.icon]
                                     else
                                       ['Cartão Indisponível', '']
                                     end
    end
  end
end
