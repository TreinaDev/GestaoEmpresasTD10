class CreateCompaniesDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :companies_departments do |t|
      t.references :company, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
