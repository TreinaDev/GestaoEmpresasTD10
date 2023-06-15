class AddIndexToCodeInDepartments < ActiveRecord::Migration[7.0]
  def change
    add_index :departments, :code, unique: true
    change_column_null :departments, :code, false
  end
end
