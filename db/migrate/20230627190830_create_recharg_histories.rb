class CreateRechargHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :recharg_histories do |t|
      t.integer :value
      t.date :recharge_date
      t.references :created_by, references: :users, null: false, foreign_key: { to_table: :users}
      t.references :employee_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
