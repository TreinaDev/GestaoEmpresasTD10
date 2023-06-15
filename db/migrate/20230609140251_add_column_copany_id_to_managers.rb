class AddColumnCopanyIdToManagers < ActiveRecord::Migration[7.0]
  def change
    add_reference :managers, :company
  end
end
