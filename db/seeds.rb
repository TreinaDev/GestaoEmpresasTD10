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

User.create!(email: 'manager@apple.com', cpf: '44429533768', password: 'password')
User.create!(email: 'manager@microsoft.com', cpf: '28543435064', password: 'password')
User.create!(email: 'manager@google.com', cpf: '85488790098', password: 'password')

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
  status: true
)

Department.create!(company_id: company.id, name: 'rh')

# position = Position.create!(department_id: department.id, name: 'gerente')

# Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
#                  user_id: manager.id)
# Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
#                  user_id: manager2.id)
# Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id,
#                  user_id: manager3.id)
