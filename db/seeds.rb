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
Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER001', description: 'Gerente do RH')
Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'ERH001', description: 'Estagiário RH')
EmployeeProfile.create!(name: 'Primeiro Funcionário', cpf: '86121830301', rg: '86121830302',
                        address: 'Rua do funcionário da apple', email: 'funcionário@apple.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário@apple.com', password: 'password', cpf: '86121830301')

Department.create!(company_id: Company.last.id, name: 'Financeiro', code: 'FIN001', description: 'Setor Financeiro')
Position.create!(department_id: Department.last.id, name: 'Administrador', code: 'ADM001',
                 description: 'Administrador no departamento do financeiro')
EmployeeProfile.create!(name: 'Segundo Funcionário', cpf: '09414728686', rg: '09414728685',
                        address: 'Rua do funcionário da apple', email: 'funcionário2@apple.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário2@apple.com', password: 'password', cpf: '09414728686')

Position.create!(department_id: Department.last.id, name: 'Tesoureiro', code: 'TES001',
                 description: 'Tesoureiro no departamento do financeiro')
EmployeeProfile.create!(name: 'Terceiro Funcionário', cpf: '73092985192', rg: '73092985193',
                        address: 'Rua do funcionário da apple', email: 'funcionário3@apple.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário3@apple.com', password: 'password', cpf: '73092985192')

Position.create!(department_id: Department.last.id, name: 'Contador', code: 'CON001',
                 description: 'Contador no departamento do financeiro')
EmployeeProfile.create!(name: 'Quarto Funcionário', cpf: '97804623259', rg: '97804623258',
                        address: 'Rua do funcionário da apple', email: 'funcionário4@apple.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário4@apple.com', password: 'password', cpf: '97804623259')

Department.create!(company_id: Company.last.id, name: 'Jurídico', code: 'JUR001', description: 'Setor Jurídico')
Position.create!(department_id: Department.last.id, name: 'Advogado', code: 'ADV001',
                 description: 'Advogado no departamento do Jurídico')
EmployeeProfile.create!(name: 'Quinto Funcionário', cpf: '45405837946', rg: '45405837945',
                        address: 'Rua do funcionário da apple', email: 'funcionário5@apple.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário5@apple.com', password: 'password', cpf: '45405837946')

Position.create!(department_id: Department.last.id, name: 'Secretário', code: 'SEC001',
                 description: 'Secretário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sexto Funcionário', cpf: '43557512444', rg: '43557512445',
                        address: 'Rua do funcionário da apple', email: 'funcionário6@apple.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário6@apple.com', password: 'password', cpf: '43557512444')

Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'EJU001',
                 description: 'Estagiário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sétimo Funcionário', cpf: '37467825544', rg: '37467825545',
                        address: 'Rua do funcionário da apple', email: 'funcionário7@apple.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário7@apple.com', password: 'password', cpf: '37467825544')

ManagerEmails.create(email: 'manager@apple.com', created_by: User.first, company_id: Company.last.id)
User.create!(email: 'manager@apple.com', password: 'password', cpf: '86899364247')
EmployeeProfile.create!(name: 'Gerente Apple', cpf: '86899364247', rg: '86899364246',
                        address: 'Rua do gerente da apple', email: 'manager@apple.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.first.id,
                        position_id: Position.first.id, card_status: false, user_id: User.last.id)

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

rh_campuscode = Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH003',
                                   description: 'Recursos Humanos')
manager_campuscode = Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER003',
                                      description: 'Gerente do RH')
Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'ERH003', description: 'Estagiário RH')
EmployeeProfile.create!(name: 'Primeiro Funcionário', cpf: '62106308396', rg: '62106308392',
                        address: 'Rua do funcionário da Campus', email: 'funcionário@campuscode.com',
                        phone_number: '41998989898', status: 'fired', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário@campuscode.com', password: 'password', cpf: '62106308396')

Department.create!(company_id: Company.last.id, name: 'Financeiro', code: 'FIN003',
                   description: 'Setor Financeiro')
Position.create!(department_id: Department.last.id, name: 'Administrador', code: 'ADM003',
                 description: 'Administrador do departamento financeiro')
EmployeeProfile.create!(name: 'Segundo Funcionário', cpf: '13326203535', rg: '13326203534',
                        address: 'Rua do funcionário da Campus', email: 'funcionário2@campuscode.com',
                        phone_number: '41998989898', status: 'fired', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário2@campuscode.com', password: 'password', cpf: '13326203535')

Position.create!(department_id: Department.last.id, name: 'Tesoureiro', code: 'TES003',
                 description: 'Tesoureiro no departamento do financeiro')
EmployeeProfile.create!(name: 'Terceiro Funcionário', cpf: '50651819504', rg: '50651819502',
                        address: 'Rua do funcionário da Campus', email: 'funcionário3@campuscode.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário3@campuscode.com', password: 'password', cpf: '50651819504')

Position.create!(department_id: Department.last.id, name: 'Contador', code: 'CON003',
                 description: 'Contador no departamento do financeiro')
EmployeeProfile.create!(name: 'Quarto Funcionário', cpf: '13512160662', rg: '13512160661',
                        address: 'Rua do funcionário da Campus', email: 'funcionário4@campuscode.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário4@campuscode.com', password: 'password', cpf: '13512160662')

Department.create!(company_id: Company.last.id, name: 'Jurídico', code: 'JUR003', description: 'Setor Jurídico')
Position.create!(department_id: Department.last.id, name: 'Advogado', code: 'ADV003',
                 description: 'Advogado no departamento do Jurídico')
EmployeeProfile.create!(name: 'Quinto Funcionário', cpf: '76941583444', rg: '76941583443',
                        address: 'Rua do funcionário da Campus', email: 'funcionário5@campuscode.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário5@campuscode.com', password: 'password', cpf: '76941583444')

Position.create!(department_id: Department.last.id, name: 'Secretário', code: 'SEC003',
                 description: 'Secretário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sexto Funcionário', cpf: '75426591113', rg: '75426591112',
                        address: 'Rua do funcionário da Campus', email: 'funcionário6@campuscode.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário6@campuscode.com', password: 'password', cpf: '75426591113')

Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'EJU003',
                 description: 'Estagiário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sétimo Funcionário', cpf: '35137643831', rg: '35137643832',
                        address: 'Rua do funcionário da Campus', email: 'funcionário7@campuscode.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário7@campuscode.com', password: 'password', cpf: '35137643831')

ManagerEmails.create!(email: 'manager@campuscode.com', created_by: User.first, company_id: Company.last.id)
User.create!(email: 'manager@campuscode.com', password: 'password', cpf: '43679150008')
EmployeeProfile.create!(name: 'Gerente Campus Code', cpf: '43679150008', rg: '43679150000',
                        address: 'Rua do gerente da Campus Code', email: 'manager@campuscode.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: rh_campuscode.id,
                        position_id: manager_campuscode.id, card_status: false, user_id: User.last.id)

# Quarta empresa
Company.create!(brand_name: 'Rebase', corporate_name: 'Rebase LTDA',
                registration_number: '12.345.678/0004-95',
                address: 'Rua da Rebase, 6000', phone_number: '11 99999-4444',
                email: 'company@rebase.com',
                domain: 'rebase.com',
                logo: { io: Rails.root.join('spec/support/images/rebase.png').open,
                        filename: 'rebase.png', content_type: 'image/png' },
                active: true)

rh_rebase = Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH004',
                               description: 'Recursos Humanos')
manager_rebase = Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER004',
                                  description: 'Gerente do RH')
Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'ERH004', description: 'Estagiário RH')
EmployeeProfile.create!(name: 'Primeiro Funcionário', cpf: '04416905050', rg: '04416905000',
                        address: 'Rua do funcionário da Rebase', email: 'funcionário@rebase.com',
                        phone_number: '41998989898', status: 'blocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário@rebase.com', password: 'password', cpf: '04416905050')

Department.create!(company_id: Company.last.id, name: 'Financeiro', code: 'FIN004',
                   description: 'Setor Financeiro')
Position.create!(department_id: Department.last.id, name: 'Administrador', code: 'ADM004',
                 description: 'Administrador do departamento financeiro')
EmployeeProfile.create!(name: 'Segundo Funcionário', cpf: '18554008049', rg: '18554008000',
                        address: 'Rua do funcionário da Rebase', email: 'funcionário2@rebase.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário2@rebase.com', password: 'password', cpf: '18554008049')

Position.create!(department_id: Department.last.id, name: 'Tesoureiro', code: 'TES004',
                 description: 'Tesoureiro no departamento do financeiro')
EmployeeProfile.create!(name: 'Terceiro Funcionário', cpf: '80614943027', rg: '80614943000',
                        address: 'Rua do funcionário da Rebase', email: 'funcionário3@rebase.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário3@rebase.com', password: 'password', cpf: '80614943027')

Position.create!(department_id: Department.last.id, name: 'Contador', code: 'CON004',
                 description: 'Contador no departamento do financeiro')
EmployeeProfile.create!(name: 'Quarto Funcionário', cpf: '97024755032', rg: '97024755000',
                        address: 'Rua do funcionário da Rebase', email: 'funcionário4@rebase.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário4@rebase.com', password: 'password', cpf: '97024755032')

Department.create!(company_id: Company.last.id, name: 'Jurídico', code: 'JUR004', description: 'Setor Jurídico')
Position.create!(department_id: Department.last.id, name: 'Advogado', code: 'ADV004',
                 description: 'Advogado no departamento do Jurídico')
EmployeeProfile.create!(name: 'Quinto Funcionário', cpf: '94042561020', rg: '94042561000',
                        address: 'Rua do funcionário da Rebase', email: 'funcionário5@rebase.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário5@rebase.com', password: 'password', cpf: '94042561020')

Position.create!(department_id: Department.last.id, name: 'Secretário', code: 'SEC004',
                 description: 'Secretário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sexto Funcionário', cpf: '74441555008', rg: '74441555000',
                        address: 'Rua do funcionário da Rebase', email: 'funcionário6@rebase.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário6@rebase.com', password: 'password', cpf: '74441555008')

Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'EJU004',
                 description: 'Estagiário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sétimo Funcionário', cpf: '90166689009', rg: '90166689000',
                        address: 'Rua do funcionário da Rebase', email: 'funcionário7@rebase.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário7@rebase.com', password: 'password', cpf: '90166689009')

ManagerEmails.create!(email: 'manager@rebase.com', created_by: User.first, company_id: Company.last.id)
User.create!(email: 'manager@rebase.com', password: 'password', cpf: '62822359016')
EmployeeProfile.create!(name: 'Gerente Rebase', cpf: '62822359016', rg: '62822359010',
                        address: 'Rua do gerente da Rebase', email: 'manager@rebase.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: rh_rebase.id,
                        position_id: manager_rebase.id, card_status: false, user_id: User.last.id)

# Quinta empresa
Company.create!(brand_name: 'Brainn', corporate_name: 'Brainn.CO LTDA',
                registration_number: '12.345.678/0005-95',
                address: 'Rua da Brainn, 6000', phone_number: '11 99999-5555',
                email: 'company@brainn.com',
                domain: 'brainn.com',
                logo: { io: Rails.root.join('spec/support/images/brainn.png').open,
                        filename: 'brainn.png', content_type: 'image/png' },
                active: true)

rh_brainn = Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH005',
                               description: 'Recursos Humanos')
manager_brainn = Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER005',
                                  description: 'Gerente do RH')
Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'ERH005', description: 'Estagiário RH')
EmployeeProfile.create!(name: 'Primeiro Funcionário', cpf: '33965530046', rg: '33965530000',
                        address: 'Rua do funcionário da Brainn', email: 'funcionário@brainn.com',
                        phone_number: '41998989898', status: 'blocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário@brainn.com', password: 'password', cpf: '33965530046')

Department.create!(company_id: Company.last.id, name: 'Financeiro', code: 'FIN005',
                   description: 'Setor Financeiro')
Position.create!(department_id: Department.last.id, name: 'Administrador', code: 'ADM005',
                 description: 'Administrador do departamento financeiro')
EmployeeProfile.create!(name: 'Segundo Funcionário', cpf: '35330824079', rg: '35330824000',
                        address: 'Rua do funcionário da Brainn', email: 'funcionário2@brainn.com',
                        phone_number: '41998989898', status: 'blocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário2@brainn.com', password: 'password', cpf: '35330824079')

Position.create!(department_id: Department.last.id, name: 'Tesoureiro', code: 'TES005',
                 description: 'Tesoureiro no departamento do financeiro')
EmployeeProfile.create!(name: 'Terceiro Funcionário', cpf: '53481555008', rg: '53481555008',
                        address: 'Rua do funcionário da Brainn', email: 'funcionário3@brainn.com',
                        phone_number: '41998989898', status: 'blocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário3@brainn.com', password: 'password', cpf: '53481555008')

Position.create!(department_id: Department.last.id, name: 'Contador', code: 'CON005',
                 description: 'Contador no departamento do financeiro')
EmployeeProfile.create!(name: 'Quarto Funcionário', cpf: '68165838091', rg: '68165838000',
                        address: 'Rua do funcionário da Brainn', email: 'funcionário4@brainn.com',
                        phone_number: '41998989898', status: 'blocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário4@brainn.com', password: 'password', cpf: '68165838091')

Department.create!(company_id: Company.last.id, name: 'Jurídico', code: 'JUR005', description: 'Setor Jurídico')
Position.create!(department_id: Department.last.id, name: 'Advogado', code: 'ADV005',
                 description: 'Advogado no departamento do Jurídico')
EmployeeProfile.create!(name: 'Quinto Funcionário', cpf: '70421224029', rg: '70421224000',
                        address: 'Rua do funcionário da Brainn', email: 'funcionário5@brainn.com',
                        phone_number: '41998989898', status: 'blocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário5@brainn.com', password: 'password', cpf: '70421224029')

Position.create!(department_id: Department.last.id, name: 'Secretário', code: 'SEC005',
                 description: 'Secretário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sexto Funcionário', cpf: '05826218010', rg: '05826218000',
                        address: 'Rua do funcionário da Brainn', email: 'funcionário6@brainn.com',
                        phone_number: '41998989898', status: 'blocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário6@brainn.com', password: 'password', cpf: '05826218010')

Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'EJU005',
                 description: 'Estagiário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sétimo Funcionário', cpf: '70574272046', rg: '70574272046',
                        address: 'Rua do funcionário da Brainn', email: 'funcionário7@brainn.com',
                        phone_number: '41998989898', status: 'blocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário7@brainn.com', password: 'password', cpf: '70574272046')

ManagerEmails.create!(email: 'manager@brainn.com', created_by: User.first, company_id: Company.last.id)
User.create!(email: 'manager@brainn.com', password: 'password', cpf: '37744368002')
EmployeeProfile.create!(name: 'Gerente Brainn', cpf: '37744368002', rg: '37744368000',
                        address: 'Rua do gerente da Brainn', email: 'manager@brainn.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: rh_brainn.id,
                        position_id: manager_brainn.id, card_status: false, user_id: User.last.id)

# Sexta empresa
Company.create!(brand_name: 'Vindi', corporate_name: 'Vindi Pagamentos LTDA',
                registration_number: '12.345.678/0006-95',
                address: 'Rua da Vindi, 6000', phone_number: '11 99999-6666',
                email: 'company@vindi.com',
                domain: 'vindi.com',
                logo: { io: Rails.root.join('spec/support/images/vindi.png').open,
                        filename: 'vindi.png', content_type: 'image/png' },
                active: true)

rh_vindi = Department.create!(company_id: Company.last.id, name: 'Departamento de RH', code: 'RHH006',
                              description: 'Recursos Humanos')
manager_vindi = Position.create!(department_id: Department.last.id, name: 'Gerente', code: 'GER006',
                                 description: 'Gerente do RH')
Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'ERH006', description: 'Estagiário RH')
EmployeeProfile.create!(name: 'Primeiro Funcionário', cpf: '86274187057', rg: '862741870',
                        address: 'Rua do funcionário da Vindi', email: 'funcionário@vindi.com',
                        phone_number: '41998989898', status: 'blocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário@vindi.com', password: 'password', cpf: '86274187057')

Department.create!(company_id: Company.last.id, name: 'Financeiro', code: 'FIN006',
                   description: 'Setor Financeiro')
Position.create!(department_id: Department.last.id, name: 'Administrador', code: 'ADM006',
                 description: 'Administrador do departamento financeiro')
EmployeeProfile.create!(name: 'Segundo Funcionário', cpf: '83431218130', rg: '83431218132',
                        address: 'Rua do funcionário da Vindi', email: 'funcionário2@vindi.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário2@vindi.com', password: 'password', cpf: '83431218130')

Position.create!(department_id: Department.last.id, name: 'Tesoureiro', code: 'TES006',
                 description: 'Tesoureiro no departamento do financeiro')
EmployeeProfile.create!(name: 'Terceiro Funcionário', cpf: '69553863523', rg: '69553863524',
                        address: 'Rua do funcionário da Vindi', email: 'funcionário3@vindi.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário3@vindi.com', password: 'password', cpf: '69553863523')

Position.create!(department_id: Department.last.id, name: 'Contador', code: 'CON006',
                 description: 'Contador no departamento do financeiro')
EmployeeProfile.create!(name: 'Quarto Funcionário', cpf: '17235678844', rg: '17235678845',
                        address: 'Rua do funcionário da Vindi', email: 'funcionário4@vindi.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário4@vindi.com', password: 'password', cpf: '17235678844')

Department.create!(company_id: Company.last.id, name: 'Jurídico', code: 'JUR003', description: 'Setor Jurídico')
Position.create!(department_id: Department.last.id, name: 'Advogado', code: 'ADV006',
                 description: 'Advogado no departamento do Jurídico')
EmployeeProfile.create!(name: 'Quinto Funcionário', cpf: '81436745411', rg: '81436745412',
                        address: 'Rua do funcionário da Vindi', email: 'funcionário5@vindi.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário5@vindi.com', password: 'password', cpf: '81436745411')

Position.create!(department_id: Department.last.id, name: 'Secretário', code: 'SEC006',
                 description: 'Secretário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sexto Funcionário', cpf: '64122783461', rg: '64122783462',
                        address: 'Rua do funcionário da Vindi', email: 'funcionário6@vindi.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário6@vindi.com', password: 'password', cpf: '64122783461')

Position.create!(department_id: Department.last.id, name: 'Estagiário', code: 'EJU006',
                 description: 'Estagiário no departamento do Jurídico')
EmployeeProfile.create!(name: 'Sétimo Funcionário', cpf: '15884280793', rg: '15884280794',
                        address: 'Rua do funcionário da Vindi', email: 'funcionário7@vindi.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: Department.last.id,
                        position_id: Position.last.id, card_status: false)
User.create!(email: 'funcionário7@vindi.com', password: 'password', cpf: '15884280793')

ManagerEmails.create!(email: 'manager@vindi.com', created_by: User.first, company_id: Company.last.id)
User.create!(email: 'manager@vindi.com', password: 'password', cpf: '83461307084')
EmployeeProfile.create!(name: 'Gerente Vindi', cpf: '83461307084', rg: '83461307000',
                        address: 'Rua do gerente da Vindi', email: 'manager@vindi.com',
                        phone_number: '41998989898', status: 'unblocked', birth_date: '10/01/2000',
                        admission_date: '29/06/2023',
                        marital_status: 'married', department_id: rh_vindi.id,
                        position_id: manager_vindi.id, card_status: false, user_id: User.last.id)
