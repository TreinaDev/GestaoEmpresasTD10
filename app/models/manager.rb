class Manager < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :company
  validates :email, presence: true

  enum status: { canceled: false, active: true }

  validate :email_equal_to_do_domain
  validate :email_exists_active?, on: :create

  validates :email, format: /\A[^@\s]+@[^@\s]+\z/

  def email_equal_to_do_domain
    if email.present?
      domain = email.split('@')[-1]
      errors.add(:email, 'precisa ser do domínio de uma empresa') unless Company.find_by(domain:)
    else
      errors.add(:email, 'precisa ser do domínio de uma empresa')
    end
  end

  def email_exists_active?
    errors.add(:email, 'já cadastrado') if email.present? && Manager.where(email:).active.any?
  end
end
