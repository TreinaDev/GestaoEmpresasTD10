class Manager < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :company
  validates :email, presence: true

  enum status: { canceled: false, active: true }

  validate :email_equal_to_do_domain
  validate :email_exists_active?, on: :create
  validate :created_by_must_be_admin
  validate :email_exists_in_a_user?

  validates :email, format: /\A[^@\s]+@[^@\s]+\z/

  def email_equal_to_do_domain
    if email.present? && company.present?
      domain = email.split('@')[-1]
      errors.add(:email, 'domínio do email não pertence a empresa') unless
                                                                    Company.where(id: company.id, domain:).first
    else
      errors.add(:email, 'domínio do email não pertence a empresa')
    end
  end

  def email_exists_active?
    errors.add(:email, 'já cadastrado') if email.present? && Manager.where(email:).active.any?
  end

  def created_by_must_be_admin
    errors.add(:created_by, 'deve ser administrador') unless created_by.present? && created_by.admin?
  end

  def email_exists_in_a_user?
    errors.add(:email, 'já cadastrado em um usuário') if User.where(email:).any?
  end
end
