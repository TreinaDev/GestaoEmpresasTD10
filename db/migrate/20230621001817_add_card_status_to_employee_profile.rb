class AddCardStatusToEmployeeProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :employee_profiles, :card_status, :boolean, default: false
  end
end
