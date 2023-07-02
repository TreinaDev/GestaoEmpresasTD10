class AddStandardRechargeToPositions < ActiveRecord::Migration[7.0]
  def change
    add_column :positions, :standard_recharge, :float, default: 0
  end
end
