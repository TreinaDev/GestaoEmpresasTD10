class RenameCreateByToCreatedByInManagers < ActiveRecord::Migration[7.0]
  def change
    rename_column :managers, :create_by_id, :created_by_id
  end
end
