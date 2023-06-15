class RenameEmployeeToEmployeeProfile < ActiveRecord::Migration[7.0]
  def change
    rename_table :employees, :employee_profiles
  end
end
