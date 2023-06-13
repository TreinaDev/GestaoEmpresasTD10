class CompaniesController < AdminController
  before_action :authenticate_user!
  before_action :require_admin, only: %i[index new create]

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @manager = Manager.new
    used_emails = User.manager.all.pluck('email')
    @emails = Manager.active.where(company: @company).where.not(email: used_emails)
  end

  def new
    @company = Company.new
  end

  def create
    company_params = params.require(:company).permit(:brand_name, :corporate_name,
                                                     :registration_number, :address,
                                                     :phone_number, :email, :domain, :logo)
    @company = Company.new company_params

    return redirect_to @company, notice: t('.success') if @company.save

    flash.now[:alert] = t('.failure')
    render :new
  end
end
