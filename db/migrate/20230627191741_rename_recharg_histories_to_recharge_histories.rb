class RenameRechargHistoriesToRechargeHistories < ActiveRecord::Migration[7.0]
  def change
    rename_table :recharg_histories, :recharge_histories
  end
end
