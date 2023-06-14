# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
first_company = Company.create!(brand_name: 'Google', corporate_name: 'Google LTDA', registration_number: '123456789',
                                address: 'Rua abigail, 13', phone_number: '90908765433', email: 'contato@gmail.com',
                                domain: 'gmail.com', status: true)
Company.create!(brand_name: 'Outlook', corporate_name: 'Outlook LTDA', registration_number: '123456789',
                address: 'Rua abigail, 13', phone_number: '90900755433', email: 'contato@outlook.com',
                domain: 'outlook.com', status: true)
user = User.create!(email: 'admin@gmail.com', cpf: '05823272294', password: 'password', role: 0)
Manager.create!(email: 'zezinho@gmail.com', created_by: user, company_id: first_company.id)
Manager.create!(email: 'mariazinha@gmail.com', created_by: user, company_id: first_company.id)
User.create!([
               {
                 email: 'walisson@punti.com',
                 password: 'password',
                 cpf: '71056473029'
               },

               {
                 email: 'bruno@punti.com',
                 password: 'password',
                 cpf: '43302699026'
               }
             ])

Manager.create!([
                  {
                    email: 'manager@apple.com',
                    created_by: User.first
                  },

                  {
                    email: 'manager@microsoft.com',
                    created_by: User.first
                  },

                  {
                    email: 'manager@google.com',
                    created_by: User.first
                  }
                ])

manager = User.create!(email: 'manager@apple.com', cpf: '44429533768', password: 'password')
manager2 = User.create!(email: 'manager@microsoft.com', cpf: '28543435064', password: 'password')
manager3 = User.create!(email: 'manager@google.com', cpf: '85488790098', password: 'password')

company = Company.new(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                      registration_number: '12.345.678/0001-95',
                      address: 'Rua California, 3000', phone_number: '11 99999-9999',
                      email: 'company@apple.com',
                      domain: 'apple.com', active: true)
company.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                    filename: 'logo.png', content_type: 'logo.png')

company2 = Company.new(brand_name: 'Microsoft', corporate_name: 'Microsoft Corporation',
                       registration_number: '12.345.678/0002-95',
                       address: 'Rua do Vale, 1000', phone_number: '11 99999-9999',
                       email: 'company@microsoft.com',
                       domain: 'microsoft.com', active: true)

company2.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                     filename: 'logo.png', content_type: 'logo.png')

company3 = Company.new(brand_name: 'IBM', corporate_name: 'IBM Corporation',
                       registration_number: '12.345.678/0003-95',
                       address: 'Rua do Silício, 6000', phone_number: '11 99999-9999',
                       email: 'company@ibm.com',
                       domain: 'ibm.com', active: false)

company3.logo.attach(io: Rails.root.join('spec/support/images/logo.png').open,
                     filename: 'logo.png', content_type: 'logo.png')
company.save!
company2.save!
company3.save!

department = Department.create!(company_id: company.id, name: 'rh')

position = Position.create!(department_id: department.id, name: 'gerente')

Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
                 user_id: manager.id)
Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
                 user_id: manager2.id)
Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
                 user_id: manager3.id)
