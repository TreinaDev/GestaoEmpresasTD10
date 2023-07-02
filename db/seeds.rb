# Criação de admins
User.create!(email: 'admin@punti.com', password: 'password', cpf: '71056473029')
User.create!(email: 'admin2@punti.com', password: 'password', cpf: '43302699026')

# Primeira empresa
Company.create!(brand_name: 'Apple', corporate_name: 'Apple LTDA',
                registration_number: '12.345.678/0001-95',
                address: 'Rua California, 3000', phone_number: '11 99999-1111',
                email: 'company@apple.com',
                domain: 'apple.com',
                logo: { io: Rails.root.join('spec/support/images/apple.png').open,
                        filename: 'apple.png', content_type: 'image/png' },
                active: true)

Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH001',
                   description: 'Recursos Humanos')
Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER001', description: 'Gerente geral')

# Segunda empresa
Company.create!(brand_name: 'Microsoft', corporate_name: 'Microsoft Corporation',
                registration_number: '12.345.678/0002-95',
                address: 'Rua do Vale, 1000', phone_number: '11 99999-2222',
                email: 'company@microsoft.com',
                domain: 'microsoft.com',
                logo: { io: Rails.root.join('spec/support/images/microsoft.jpg').open,
                        filename: 'microsoft.jpg', content_type: 'image/jpg' },
                active: true)

rh_microsoft = Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH002',
                                  description: 'Recursos Humanos')
manager_microsoft = Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER002',
                                     description: 'Gerente do RH')
Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'ERH002', description: 'Estagiário RH')
EmployeeProfile.create!(name: 'Primeiro Funcionário', cpf: '25710896098', rg: '25710896000',
                        address: 'Rua do funcionário da microsoft', email: 'funcionário@microsoft.com',
                        phone_number: '41998989898', status: 'blocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário@microsoft.com', password: 'password', cpf: '25710896098')

Department.create!(company_id: Company.last.id, name: 'Financeiro', code: 'FIN002',
                   description: 'Setor Financeiro')
Position.create!(department_id: Department.last.id, name: 'Administrador', code: 'ADM002',
                 description: 'Administrador do departamento financeiro')
EmployeeProfile.create!(name: 'Segundo Funcionário', cpf: '26257310520', rg: '26257310524',
                        address: 'Rua do funcionário da microsoft', email: 'funcionário2@microsoft.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário2@microsoft.com', password: 'password', cpf: '26257310520')

Position.create!(department_id: Department.last.id, name: 'Tesoureiro', code: 'TES002',
                 description: 'Tesoureiro no departamento do financeiro')
EmployeeProfile.create!(name: 'Terceiro Funcionário', cpf: '45653732621', rg: '45653732622',
                        address: 'Rua do funcionário da microsoft', email: 'funcionário3@microsoft.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário3@microsoft.com', password: 'password', cpf: '45653732621')

Position.create!(department_id: Department.last.id, name: 'Contador', code: 'CON002',
                 description: 'Contador no departamento do financeiro')
EmployeeProfile.create!(name: 'Quarto Funcionário', cpf: '82415259152', rg: '82415259154',
                        address: 'Rua do funcionário da microsoft', email: 'funcionário4@microsoft.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário4@microsoft.com', password: 'password', cpf: '82415259152')

Department.create!(company_id: Company.last.id, name: 'Jurídico', code: 'JUR002', description: 'Setor Jurídico')
Position.create!(department_id: Department.last.id, name: 'Advogado', code: 'ADV002',
                 description: 'Advogado no departamento do Jurídico')
EmployeeProfile.create!(name: 'Quinto Funcionário', cpf: '32451153423', rg: '32451153424',
                        address: 'Rua do funcionário da microsoft', email: 'funcionário5@microsoft.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário5@microsoft.com', password: 'password', cpf: '32451153423')

Position.create!(department_id: Department.last.id, name: 'Secretário', code: 'SEC002',
                 description: 'Secretário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sexto Funcionário', cpf: '62205375482', rg: '62205375483',
                        address: 'Rua do funcionário da microsoft', email: 'funcionário6@microsoft.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário6@microsoft.com', password: 'password', cpf: '62205375482')

Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'EJU002',
                 description: 'Estagiário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sétimo Funcionário', cpf: '09813732750', rg: '09813732751',
                        address: 'Rua do funcionário da microsoft', email: 'funcionário7@microsoft.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário7@microsoft.com', password: 'password', cpf: '09813732750')

ManagerEmails.create!(email: 'manager@microsoft.com', created_by: User.first, company_id: Company.last.id)
User.create!(email: 'manager@microsoft.com', password: 'password', cpf: '74241239129')
EmployeeProfile.create!(name: 'Gerente Microsoft', cpf: '74241239129', rg: '74241239121',
                        address: 'Rua do gerente da microsoft', email: 'manager@microsoft.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: rh_microsoft.id,
                        position_id: manager_microsoft.id, card_status: false, user_id: User.last.id)

# Terceira empresa
Company.create!(brand_name: 'Campus Code', corporate_name: 'Campus Code LTDA',
                registration_number: '12.345.678/0003-95',
                address: 'Rua da Campus Code, 6000', phone_number: '11 99999-3333',
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
ManagerEmails.create!(email: 'manager@apple.com', created_by: User.first, company_id: Company.first.id)
ManagerEmails.create!(email: 'manager@microsoft.com', created_by: User.first,
                      company_id: Company.find_by(brand_name: 'Microsoft').id)

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

ManagerEmails.create!(email: 'manager@vindi.com', created_by: User.first, company_id: Company.last.id)
User.create!(email: 'manager@vindi.com', password: 'password', cpf: '83461307084')
EmployeeProfile.create!(name: 'Gerente Vindi', cpf: '83461307084', rg: '83461307000',
                        address: 'Rua do gerente da Vindi', email: 'manager@vindi.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: rh_vindi.id,
                        position_id: manager_vindi.id, card_status: false, user_id: User.last.id)
