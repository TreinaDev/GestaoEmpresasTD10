class AddIndexToEmployeeRg < ActiveRecord::Migration[7.0]
  def change
    add_index :employee_profiles, :rg, unique: true
  end
end
