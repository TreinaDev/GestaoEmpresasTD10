class CreateRechargeHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :recharge_histories do |t|
      t.float :value
      t.date :recharge_date
      t.references :employee_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
