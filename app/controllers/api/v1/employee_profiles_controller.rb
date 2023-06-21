class Api::V1::EmployeeProfilesController < Api::V1::ApiController
  def index
    employee_profiles = if params[:cpf]
                          EmployeeProfile.where(cpf: params[:cpf])
                        else
                          EmployeeProfile.all
                        end

    render status: :ok, json: format_employee_profile(employee_profiles)
  end

  private

  def format_employee_profile(employee_profiles)
    employee_profiles.map do |profile|
      {
        id: profile.id,
        name: profile.name,
        cpf: profile.cpf,
        status: profile.status,
        company_cnpj: profile.department.company.registration_number
      }
    end
  end
end
