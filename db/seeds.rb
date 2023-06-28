company1 = Company.create!(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                registration_number: '02423374000145',
                address: 'Rua California, 3000', phone_number: '11 99999-9999',
                email: 'company@apple.com',
                domain: 'apple.com',
                logo: { io: Rails.root.join('spec/support/images/apple.png').open,
                        filename: 'apple.png', content_type: 'image/png' },
                active: true)

department1 = Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH001',
                   description: 'Recursos Humanos')
position1 = Position.create!(
	department_id: Department.last.id, name: 'Gerente', code: 'GER001', description: 'Gerente geral',
	card_type_id: 1
	)

position2 = Position.create!(
	department_id: Department.last.id, name: 'Auxiliar', code: 'AUX001', description: 'Auxiliar geral',
	card_type_id: 1
	)

Company.create!(brand_name: 'Microsoft', corporate_name: 'Microsoft Corporation',
                registration_number: '12.345.678/0002-95',
                address: 'Rua do Vale, 1000', phone_number: '11 99999-9999',
                email: 'company@microsoft.com',
                domain: 'microsoft.com',
                logo: { io: Rails.root.join('spec/support/images/microsoft.jpg').open,
                        filename: 'microsoft.jpg', content_type: 'image/jpg' },
                active: true)

Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH002',
                   description: 'Recursos Humanos')
Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER002', description: 'Gerente geral')

Company.create!(brand_name: 'Campus Code', corporate_name: 'Campus Code LTDA',
                registration_number: '12.345.678/0003-95',
                address: 'Rua da Campus Code, 6000', phone_number: '11 99999-9999',
                email: 'company@campuscode.com',
                domain: 'campuscode.com',
                logo: { io: Rails.root.join('spec/support/images/logo.png').open,
                        filename: 'logo.png', content_type: 'image/png' },
                active: true)

Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH003',
                   description: 'Recursos Humanos')
Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER003', description: 'Gerente geral')

User.create!(email: 'admin@punti.com', password: 'password', cpf: '71056473029')
User.create!(email: 'otheradmin@punti.com', password: 'password', cpf: '43302699026')

ManagerEmails.create!(email: 'zezinho@apple.com', created_by: User.first, company_id: Company.first.id)
ManagerEmails.create!(email: 'mariazinha@apple.com', created_by: User.first, company_id: Company.first.id)
me1 = ManagerEmails.create!(email: 'manager@apple.com', created_by: User.first, company_id: Company.first.id)
ManagerEmails.create!(email: 'manager@microsoft.com', created_by: User.first,
                      company_id: Company.find_by(brand_name: 'Microsoft').id)

manager1 = User.create!(email: 'manager@apple.com', password: 'password', cpf: '80893978329')
FactoryBot.create(:employee_profile,
	email: 'manager@apple.com', cpf: '80893978329', social_name: 'Gerentildo da Silva', name: 'Gerencio',
	department: department1, position: position1, user: manager1
)

FactoryBot.create(:employee_profile,
	email: 'func1@apple.com', cpf: '97695869430', social_name: 'Funcionaldo da Silva', name: 'Funcio',
	department: department1, position: position2
)
User.create!(email: 'func1@apple.com', password: 'password', cpf: '97695869430')

FactoryBot.create(:employee_profile,
	email: 'func2@apple.com', cpf: '58636553059', social_name: 'Funcionaldo2 da Silva', name: 'Funcio2',
	department: department1, position: position2
)
User.create!(email: 'func2@apple.com', password: 'password', cpf: '58636553059')


Department.create!(company_id: Company.first.id, name: 'RH', code: 'D34B5A',
                   description: 'Departamento de Recursos Humanos')
Department.create!(company_id: Company.first.id, name: 'Financeiro', code: 'CBA321',
                   description: 'Departamento do Financeiro')
Department.create!(company_id: Company.first.id, name: 'Marketing', code: 'ABC123',
                   description: 'Departamento de Marketing')

Position.create!(department_id: Department.first.id, name: 'Gerente de RH', description: 'Gerente de RH',
                 card_type_id: 1, code: 'OIU584')

# Company.create!(brand_name: 'Apple', corporate_name: 'Apple LTDA',
#         registration_number: '12.345.678/0001-95',
#         address: 'Rua California, 3000', phone_number: '11 99999-9999',
#         email: 'company@apple.com',
#         domain: 'apple.com',
#         logo: { io: Rails.root.join('spec/support/images/apple.png').open,
#                 filename: 'apple.png', content_type: 'image/png' },
#         active: true)

# Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH001',
#            description: 'Recursos Humanos')
# Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER001', description: 'Gerente geral')

# Company.create!(brand_name: 'Microsoft', corporate_name: 'Microsoft Corporation',
#                         registration_number: '12.345.678/0002-95',
#                         address: 'Rua do Vale, 1000', phone_number: '11 99999-9999',
#                         email: 'company@microsoft.com',
#                         domain: 'microsoft.com',
#                         logo: { io: Rails.root.join('spec/support/images/microsoft.jpg').open,
#                                 filename: 'microsoft.jpg', content_type: 'image/jpg' },
#                         active: true)

# Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH002',
#            description: 'Recursos Humanos')
# Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER002', description: 'Gerente geral')

# Company.create!(brand_name: 'IBM', corporate_name: 'IBM Corporation',
#         registration_number: '12.345.678/0003-95',
#         address: 'Rua do Silício, 6000', phone_number: '11 99999-9999',
#         email: 'company@ibm.com',
#         domain: 'ibm.com',
#         logo: { io: Rails.root.join('spec/support/images/IBM.jpg').open,
#                 filename: 'IBM.jpg', content_type: 'image/jpg' },
#         active: true)

# Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH003',
#            description: 'Recursos Humanos')

# Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER003', description: 'Gerente geral')

# User.create!(email: 'admin@punti.com', password: 'password', cpf: '71056473029')
# User.create!(email: 'otheradmin@punti.com', password: 'password', cpf: '43302699026')

# Department.create!(company_id: Company.first.id, name: 'RH', code: 'D34B5A',
#            description: 'Departamento de Recursos Humanos')
# Department.create!(company_id: Company.first.id, name: 'Financeiro', code: 'CBA321',
#            description: 'Departamento do Financeiro')
# Department.create!(company_id: Company.first.id, name: 'Marketing', code: 'ABC123',
#            description: 'Departamento de Marketing')
