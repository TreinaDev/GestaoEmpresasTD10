class Department < ApplicationRecord
  belongs_to :company
  before_validation :set_code, on: :create
  validates :name, :description, :code, presence: true
  validates :code, uniqueness: true

  private

  def set_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
