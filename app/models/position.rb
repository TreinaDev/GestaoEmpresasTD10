class Position < ApplicationRecord
  has_many :employee_profiles, dependent: :nullify
  belongs_to :department
  before_validation :set_code, on: :create
  has_one :company, through: :department
  validates :name, :description, :code, presence: true
  validates :code, uniqueness: true, format: { with: /\A[A-Z]{3}\d{3}\z/, message: :invalid_format }

  private

  def set_code
    letters = ('A'..'Z').to_a.sample(3).join
    numbers = format('%03d', rand(1000))
    self.code = letters + numbers
  end
end
