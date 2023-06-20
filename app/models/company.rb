class Company < ApplicationRecord
  has_one_attached :logo
  has_many :departments, dependent: :destroy
  has_many :positions, through: :departments
  validates :registration_number, uniqueness: true
  validates :brand_name, :corporate_name, :registration_number,
            :address, :phone_number, :email, :domain, :logo, presence: true

  # after_create :send_new_company_to_loja
  # after_update :send_updated_company_to_loja

  # def send_new_company_to_loja
  #   company_params = { company: {registration_number: self.registration_number,
  #                                brand_name: self.brand_name,
  #                                corporate_name: self.corporate_name,
  #                                active: self.active
  #                               }
  #                     }

  #   response = Faraday.post('http://localhost:5000/api/v1/companies', company_params)
  #   if response.status = 200
  #     puts "Envio da API deu certo!"
  #   else
  #     puts "Erro no envio da API"
  #   end
  # end

  # def send_updated_company_to_loja
  #   company_params = { company: {registration_number: self.registration_number,
  #                                brand_name: self.brand_name,
  #                                corporate_name: self.corporate_name,
  #                                active: self.active
  #                               }
  #                     }

  #   response = Faraday.put("http://localhost:5000/api/v1/companies/#{self.id}", company_params)

  #   if response.success?
  #     puts "Envio da API deu certo!"
  #   else
  #     puts "Erro no envio da API"
  #   end
  # end
end
