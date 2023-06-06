class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :registration_number
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :domain
      t.boolean :status

      t.timestamps
    end
  end
end
