class CreateManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :managers do |t|
      t.string :email
      t.references :create_by, references: :users, null: false, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
