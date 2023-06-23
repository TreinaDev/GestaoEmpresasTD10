class Api::V1::EmployeeProfilesController < Api::V1::ApiController
  def index
    employee_profiles = if params[:cpf]
                          EmployeeProfile.where(cpf: params[:cpf])
                        elsif params[:status]
                          EmployeeProfile.where(status: params[:status])
                        else
                          EmployeeProfile.all
                        end

    return no_content if employee_profiles.empty?

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
