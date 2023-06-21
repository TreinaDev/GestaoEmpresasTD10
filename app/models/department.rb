class Department < ApplicationRecord
  has_many :employee_profiles, through: :positions
  belongs_to :company
  before_validation :set_code, on: :create
  has_many :positions, dependent: nil
  validates :name, :description, :code, presence: true
  validates :code, uniqueness: true

  private

  def set_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
