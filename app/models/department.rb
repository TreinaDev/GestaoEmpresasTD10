class Department < ApplicationRecord
  belongs_to :company
  validates :name, :description, :code, presence: true
  validates :code, uniqueness: true

  validate :code_format

  private

  def code_format
    return if code.length == 6 && code.count('A-Za-z') == 3

    errors.add(:code, :invalid_format)
  end
end
