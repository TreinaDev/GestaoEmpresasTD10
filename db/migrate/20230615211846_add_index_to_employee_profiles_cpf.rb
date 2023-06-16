class AddIndexToEmployeeProfilesCpf < ActiveRecord::Migration[7.0]
  def change
    add_index :employee_profiles, :cpf, unique: true
  end
end
