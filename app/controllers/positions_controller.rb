require 'pry'
class PositionsController < ManagerController
  def show
    @position = Position.find(params[:id])
    @department = Department.find_by(id: params[:department_id])
    @company = Company.find_by(id: params[:company_id])
    response = Faraday.get("http://localhost:4000/api/v1/company_card_types?cnpj=#{@department.company.registration_number}")
    cards_types_array = JSON.parse(response.body)
    @cards_types = cards_types_array.map { |hash| OpenStruct.new(hash) }
  end

  def new
    @department = Department.find_by(id: params[:department_id])
    @company = Company.find_by(id: params[:company_id])
    @position = Position.new
    response = Faraday.get("http://localhost:4000/api/v1/company_card_types?cnpj=#{@department.company.registration_number}")
    cards_types_array = JSON.parse(response.body)
    @cards_types = cards_types_array.map { |hash| OpenStruct.new(hash) }
  end

  def create
    position_params = params.require(:position).permit(:name, :description,
                                                     :code, :card_type_id,
                                                     :department_id)
    @position = Position.new position_params
    @position.update(department_id: params[:department_id])
    return redirect_to company_department_position_path(company_id: @position.department.company.id, department_id: @position.department.id, id: @position.id), notice: t('.success') if @position.save

    flash.now[:alert] = t('.failure')
    render :new
  end
end
