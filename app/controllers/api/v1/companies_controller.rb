class Api::V1::CompaniesController < Api::V1::ApiController
  def show
    company = Company.find(params[:id])
    render status: 200, json: company.as_json(only: [:id, :registration_number, :brand_name, :corporate_name, :active])
  end

  def index
    companies = Company.all
    render status: 200, json: companies.as_json(only: [:id, :registration_number, :brand_name, :corporate_name, :active])
  end
  # def create
  #   warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
  #   warehouse = Warehouse.new(warehouse_params)
  #   if warehouse.save
  #     render status: 201, json: warehouse
  #   else
  #     render status: 412, json: { errors: warehouse.errors.full_messages }
  #   end
  # end
end