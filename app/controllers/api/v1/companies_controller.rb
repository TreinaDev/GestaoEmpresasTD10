class Api::V1::CompaniesController < Api::V1::ApiController
  def index
    companies = if params[:cnpj]
                  Company.find_by(registration_number: params[:cnpj])
                elsif params[:active]
                  Company.where(active: params[:active])
                else
                  Company.all
                end

    render status: :ok,
           json: companies.as_json(only: %i[id registration_number brand_name corporate_name active])
  end

  def show
    company = Company.find(params[:id])
    render status: :ok, json: company.as_json(only: %i[id registration_number brand_name corporate_name active])
  end
end
