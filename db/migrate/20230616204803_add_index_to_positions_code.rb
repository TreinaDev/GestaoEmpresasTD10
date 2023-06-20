class AddIndexToPositionsCode < ActiveRecord::Migration[7.0]
  def change
    add_index :positions, :code, unique: true
  end
end
