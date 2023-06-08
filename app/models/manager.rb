class Manager < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  validates :email, presence: true

  validate :email_equal_to_do_domain

  def email_equal_to_do_domain
    if email.present?
      domain = email.split('@')[1]
      errors.add(:email, 'precisa ser do domínio de uma empresa') unless Company.find_by(domain:)
    else
      errors.add(:email, 'precisa ser do domínio de uma empresa')
    end
  end
end
