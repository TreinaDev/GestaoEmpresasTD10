class AddDefaultToCompanyActiveStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default :companies, :active, from: nil, to: true
  end
end
