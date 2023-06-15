class PositionsController < ManagerController
  before_action :set_company_and_department, only: %i[show new create]
  before_action :set_position, only: %i[show]
  before_action :set_card_types, only: %i[show new]

  def show; end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new(position_params.merge(department: @department))

    if @position.save
      redirect_to [@company, @department, @position], notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new
    end
  end

  private

  def set_position
    @position = Position.find(params[:id])
    @card_type = CardType.find(@position.card_type_id, @company.registration_number)
  end

  def set_company_and_department
    @company = Company.find(params[:company_id])
    @department = @company.departments.find(params[:department_id])
  end

  def set_card_types
    @card_types = CardType.all(@company.registration_number)
  end

  def position_params
    params.require(:position).permit(:name, :description, :code, :card_type_id)
  end
end
