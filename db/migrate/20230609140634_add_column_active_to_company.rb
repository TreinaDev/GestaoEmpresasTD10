class AddColumnActiveToCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :status, :boolean, default: true
  end
end
