class Position < ApplicationRecord
  has_many :employee_profiles, dependent: :nullify
  has_one :company, through: :department
  belongs_to :department
  before_validation :set_code, on: :create
  before_save :update_standard_recharge, if: :card_type_id_changed?
  validates :name, :description, :code, presence: true
  validates :code, uniqueness: true, format: { with: /\A[A-Z]{3}\d{3}\z/, message: :invalid_format }

  private

  def set_code
    letters = ('A'..'Z').to_a.sample(3).join
    numbers = format('%03d', rand(1000))
    self.code = letters + numbers
  end

  def update_standard_recharge
    card_type = GetCardType.find(card_type_id, department.company.registration_number)
    self.standard_recharge = card_type ? card_type.start_points.to_f : 0
  end
end
