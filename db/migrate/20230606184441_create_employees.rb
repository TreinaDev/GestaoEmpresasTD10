class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :social_name
      t.string :cpf
      t.string :rg
      t.string :address
      t.string :email
      t.string :phone_number
      t.integer :status
      t.date :birth_date
      t.date :admission_date
      t.date :dismissal_date
      t.integer :marital_status
      t.references :department, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true

      t.timestamps
    end
  end
end
