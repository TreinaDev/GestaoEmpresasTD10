class ChangeValueToFloatInRechargeHistories < ActiveRecord::Migration[7.0]
  def change
    change_column :recharge_histories, :value, :float
  end
end
