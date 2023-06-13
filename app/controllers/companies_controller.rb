class CompaniesController < AdminController
  before_action :set_company, only: %i[show edit update activate deactivate]

  def index
    @active_companies = Company.where(status: true)
  end

  def inactives
    @inactive_companies = Company.where(status: false)
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit; end

  def create
    @company = Company.new company_params

    return redirect_to @company, notice: t('.success') if @company.save

    flash.now[:alert] = t('.failure')
    render :new
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: t('.success')
    else
      flash.now[:notice] = 'Não foi possível atualizar dados da empresa'
      render :edit
    end
  end

  def activate
    @company.update(status: true)
    redirect_to company_path(@company)
  end

  def deactivate
    @company.update(status: false)
    redirect_to company_path(@company)
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:brand_name, :corporate_name,
                                    :registration_number, :address,
                                    :phone_number, :email, :domain, :logo)
  end
end
