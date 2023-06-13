class AddIndexToCompaniesRegistrationNumber < ActiveRecord::Migration[7.0]
  def change
    add_index :companies, :registration_number, unique: true
  end
end
