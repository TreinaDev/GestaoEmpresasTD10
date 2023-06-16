# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Company.create!(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                registration_number: '12.345.678/0001-95',
                address: 'Rua California, 3000', phone_number: '11 99999-9999',
                email: 'company@apple.com',
                domain: 'apple.com',
                logo: { io: Rails.root.join('spec/support/images/logo.png').open,
                        filename: 'logo.png', content_type: 'image/png' },
                active: true)

Company.create!(brand_name: 'Microsoft', corporate_name: 'Microsoft Corporation',
                registration_number: '12.345.678/0002-95',
                address: 'Rua do Vale, 1000', phone_number: '11 99999-9999',
                email: 'company@microsoft.com',
                domain: 'microsoft.com',
                logo: { io: Rails.root.join('spec/support/images/logo.png').open,
                        filename: 'logo.png', content_type: 'image/png' },
                active: true)

Company.create!(brand_name: 'IBM', corporate_name: 'IBM Corporation',
                registration_number: '12.345.678/0003-95',
                address: 'Rua do Silício, 6000', phone_number: '11 99999-9999',
                email: 'company@ibm.com',
                domain: 'ibm.com',
                logo: { io: Rails.root.join('spec/support/images/logo.png').open,
                        filename: 'logo.png', content_type: 'image/png' },
                active: false)

User.create!(email: 'admin@punti.com', password: 'password', cpf: '71056473029')
User.create!(email: 'otheradmin@punti.com', password: 'password', cpf: '43302699026')

Manager.create!(email: 'zezinho@apple.com', created_by: User.first, company_id: Company.first.id)
Manager.create!(email: 'mariazinha@apple.com', created_by: User.first, company_id: Company.first.id)
Manager.create!(email: 'manager@apple.com', created_by: User.first, company_id: Company.first.id)
Manager.create!(email: 'manager@microsoft.com', created_by: User.first,
                company_id: Company.find_by(brand_name: 'Microsoft').id)
Manager.create!(email: 'manager@ibm.com', created_by: User.first, company_id: Company.last.id)

User.create!(email: 'manager@apple.com', cpf: '44429533768', password: 'password')
User.create!(email: 'manager@microsoft.com', cpf: '28543435064', password: 'password')

company = Company.create!(
  brand_name: 'Apple',
  corporate_name: 'Campus Code Treinamentos LTDA',
  registration_number: '10.394.460/0058-87',
  address: 'Rua da tecnologia, nº 1500',
  phone_number: '1130302525',
  email: 'contato@campuscode.com.br',
  domain: 'campuscode.com.br',
  logo: { io: Rails.root.join('spec/support/images/logo.png').open, filename: 'logo.png',
          content_type: 'logo/png' },
  active: true
)

Department.create!(
  company_id: company.id,
  name: 'rh',
  code: 'ABC!@#',
  description: 'Recursos humanos'
)

# position = Position.create!(department_id: department.id, name: 'gerente')

# Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
#                  user_id: manager.id)
# Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
#                  user_id: manager2.id)
# Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
#                  user_id: manager3.id)