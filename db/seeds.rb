# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
company = Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
                          address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                          domain: 'gmail.com', status: true)
user = User.create!(email: 'admin@gmail.com', password: 'password', role: 1)
Manager.create!(email: 'zezinho@gmail.com', created_by: user, company_id: company.id)
Manager.create!(email: 'mariazinha@gmail.com', created_by: user, company_id: company.id)
