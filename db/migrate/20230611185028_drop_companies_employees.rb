class DropCompaniesEmployees < ActiveRecord::Migration[7.0]
  def change
    drop_table :companies_employees
  end
end
