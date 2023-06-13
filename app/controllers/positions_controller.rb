class PositionsController < ManagerController
  def show
    @position = Position.find(params[:id])
  end

  def new
    @position = Position.new
  end

  def create
    position_params = params.require(:position).permit(:name, :description,
                                                     :code, :card_type_id,
                                                     :department_id)
    @position = Position.new position_params

    return redirect_to @position, notice: t('.success') if @position.save

    flash.now[:alert] = t('.failure')
    render :new
  end
end
