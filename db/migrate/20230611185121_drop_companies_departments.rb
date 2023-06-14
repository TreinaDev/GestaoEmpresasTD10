class DropCompaniesDepartments < ActiveRecord::Migration[7.0]
  def change
    drop_table :companies_departments
  end
end
