class HomeController < ApplicationController
  def index
    return redirect_to company_path(current_user.employee_profile.department.company) unless current_user.admin?

    @active_companies = Company.where(active: true)
  end
end
