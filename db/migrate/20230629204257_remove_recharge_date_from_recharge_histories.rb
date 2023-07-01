class RemoveRechargeDateFromRechargeHistories < ActiveRecord::Migration[7.0]
  def change
    remove_column :recharge_histories, :recharge_date
  end
end
