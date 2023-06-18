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
User.create!(email: 'manager@ibm.com', cpf: '85488790098', password: 'password')

Department.create!(company_id: Company.first.id, name: 'RH', code: 'D34B5A',
                   description: 'Departamento de Recursos Humanos')
Department.create!(company_id: Company.first.id, name: 'Financeiro', code: 'CBA321',
                   description: 'Departamento do Financeiro')
Department.create!(company_id: Company.first.id, name: 'Marketing', code: 'ABC123',
                   description: 'Departamento de Marketing')

Position.create!(department_id: Department.first.id, name: 'Gerente de RH')
Position.create!(department_id: Department.first.id, name: 'Analista de RH')
Position.create!(department_id: Department.first.id, name: 'Especialista em Treinamento')
Position.create!(department_id: Department.find_by(name: 'Financeiro').id, name: 'Contador')
Position.create!(department_id: Department.find_by(name: 'Financeiro').id, name: 'Tesoureiro')
Position.create!(department_id: Department.find_by(name: 'Financeiro').id, name: 'Auditor')
Position.create!(department_id: Department.find_by(name: 'Marketing').id, name: 'Coordernador')
Position.create!(department_id: Department.find_by(name: 'Marketing').id, name: 'Especialista em Mídia Social')
Position.create!(department_id: Department.find_by(name: 'Marketing').id, name: 'Gerente de Produto')

EmployeeProfile.create!(name: 'Employee One', social_name: 'E1', cpf: '73741924016', rg: '12345678',
                        address: 'Rua Apple, 1', email: 'employee1@apple.com', phone_number: '11 11111-1111',
                        status: 'unblocked', birth_date: '1990-01-01', admission_date: '2022-01-01',
                        marital_status: 'single', department_id: Department.first.id, position_id: Position.first.id)
EmployeeProfile.create!(name: 'Employee Two', social_name: 'E2', cpf: '39984561046', rg: '23456789',
                        address: 'Rua Apple, 2', email: 'employee2@apple.com', phone_number: '11 22222-2222',
                        status: 'unblocked', birth_date: '1991-02-02', admission_date: '2022-02-02',
                        marital_status: 'married', department_id: Department.first.id, position_id: Position.second.id)
EmployeeProfile.create!(name: 'Employee Three', social_name: 'E3', cpf: '00825818001', rg: '34567890',
                        address: 'Rua Microsoft, 3', email: 'employee3@microsoft.com', phone_number: '11 33333-3333',
                        status: 'unblocked', birth_date: '1992-03-03', admission_date: '2022-03-03',
                        marital_status: 'widower', department_id: Department.find_by(name: 'Financeiro').id,
                        position_id: Position.find_by(name: 'Contador').id)
EmployeeProfile.create!(name: 'Employee Four', social_name: 'E4', cpf: '88734404015', rg: '45678901',
                        address: 'Rua Microsoft, 4', email: 'employee4@microsoft.com', phone_number: '11 44444-4444',
                        status: 'unblocked', birth_date: '1993-04-04', admission_date: '2022-04-04',
                        marital_status: 'divorced', department_id: Department.find_by(name: 'Financeiro').id,
                        position_id: Position.find_by(name: 'Tesoureiro').id)
EmployeeProfile.create!(name: 'Employee Five', social_name: 'E5', cpf: '90678712069', rg: '56789012',
                        address: 'Rua IBM, 5', email: 'employee5@ibm.com', phone_number: '11 55555-5555',
                        status: 'unblocked', birth_date: '1994-05-05', admission_date: '2022-05-05',
                        marital_status: 'single', department_id: Department.find_by(name: 'Marketing').id,
                        position_id: Position.find_by(name: 'Coordernador').id)

User.create!(email: 'employee1@apple.com', cpf: '73741924016', password: 'password')
User.create!(email: 'employee2@apple.com', cpf: '39984561046', password: 'password')
User.create!(email: 'employee3@microsoft.com', cpf: '00825818001', password: 'password')
User.create!(email: 'employee4@microsoft.com', cpf: '88734404015', password: 'password')
User.create!(email: 'employee5@ibm.com', cpf: '90678712069', password: 'password')
