class EmployeeProfile < ApplicationRecord
  belongs_to :department
  belongs_to :user, optional: true
  belongs_to :position

  before_validation :format_phone_number

  validates :name, :cpf, :rg, :address, :email, :phone_number, :status, :birth_date, :admission_date,
            :marital_status, presence: true
  validates :cpf, uniqueness: true
  validates :rg, uniqueness: true
  validates :dismissal_date, comparison: { greater_than: Time.zone.today }, if: :dismissal_is_present?
  validates :phone_number, length: { is: 11 }

  validate :name?
  validate :email_match_company?
  validate :birth_date?
  validate :admission_date?

  enum status: { unblocked: 0, blocked: 5, fired: 10 }, _default: :unblocked
  enum marital_status: { single: 1, married: 4, widower: 8, divorced: 10 }

  private

  def dismissal_is_present?
    dismissal_date.present?
  end

  def format_phone_number
    phone_number&.gsub!(/\D/, '')
  end

  def name?
    return false if name&.match?(/\A[\p{L}]+(\s[\p{L}]+)+\z/)

    errors.add(:name, 'deve conter apenas letras e ter no mínimo duas palavras')
  end

  def email_match_company?
    company_domain = department&.company&.domain

    return false if email.blank? || email.ends_with?(company_domain)

    errors.add(:email, 'deve ser do mesmo domínio da empresa')
  end

  def birth_date?
    errors.add(:birth_date, 'deve ser no mínimo 18 anos atrás') if birth_date.present? && birth_date > 18.years.ago
  end

  def admission_date?
    if admission_date.present? && admission_date < birth_date + 18.years
      errors.add(:admission_date, 'deve ser no mínimo 18 anos depois da data de nascimento')
    elsif admission_date.present? && admission_date > Time.zone.today
      errors.add(:admission_date, 'deve ser anterior ou igual à data atual')
    end
  end
end
