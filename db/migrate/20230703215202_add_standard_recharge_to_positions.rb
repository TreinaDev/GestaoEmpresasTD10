class AddStandardRechargeToPositions < ActiveRecord::Migration[7.0]
  def change
    remove_column :positions, :standard_recharge
    add_column :positions, :standard_recharge, :float, default: 0.0
  end
end
