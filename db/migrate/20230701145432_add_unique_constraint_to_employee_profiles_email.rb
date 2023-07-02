class AddUniqueConstraintToEmployeeProfilesEmail < ActiveRecord::Migration[7.0]
  def change
    add_index :employee_profiles, :email, unique: true
  end
end
