class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :description
      t.string :code
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
