class RenameManagersTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :managers, :manager_emails
  end
end
