class Company < ApplicationRecord
  has_many :department, dependent: :nullify
  has_one_attached :logo
  has_many :departments, dependent: :destroy
  has_many :positions, through: :departments
  has_many :managers, dependent: :destroy
  validates :registration_number, uniqueness: true
  validates :brand_name, :corporate_name, :registration_number,
            :address, :phone_number, :email, :domain, :logo, presence: true
  before_validation :clean_registration_number
  before_create :post_company

  private

  def clean_registration_number
    registration_number&.gsub!(/\D/, '')
  end

  def post_company
    company_params = { 
      company: {
        registration_number: self.registration_number,
        active: self.active,
        brand_name: self.brand_name,
        corporate_name: self.corporate_name
      }
    }

    response = PostCompanyApi.new(company_params).send

    if response.status != 201
      errors.add(:base, 'Falha na criação da empresa por API')
      throw :abort
    end
  end
end
