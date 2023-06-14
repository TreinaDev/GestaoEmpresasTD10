class CreateCompaniesEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :companies_employees do |t|
      t.references :company, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
