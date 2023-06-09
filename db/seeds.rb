admins = User.create!([
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

manager = Manager.create!([
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


company = Company.create!(brand_name: 'Apple')

department = Department.create!(company_id: company.id, name: 'rh')

position = Position.create!(department_id: department.id, name: 'gerente')

employee = Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id, user_id: manager.id)
employee = Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id, user_id: manager2.id)
employee = Employee.create!(status: 'unblocked', department_id: department.id, position_id: position.id, user_id: manager3.id)