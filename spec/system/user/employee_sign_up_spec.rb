require 'rails_helper'

feature 'Registro de funcionário' do
  scenario 'com sucesso' do
    company = Company.create!(
      brand_name: 'Campus Code', corporate_name: 'Campus Code Treinamentos LTDA',
      registration_number: '00.394.460/0058-87', address: 'Rua da tecnologia, nº 1500',
      phone_number: '1130302525', email: 'contato@campuscode.com.br',
      domain: 'campuscode.com.br',
      logo: {
        io: Rails.root.join('spec/support/images/logo.png').open,
        filename: 'logo.png', content_type: 'image/png'
    })
    department = Department.create!(name: 'RH', company: company)
    position = Position.create!(name: 'estagiário', department: department)
    employee = Employee.create!(
                                  cpf: '69142235219',
                                  email: 'funcionario@empresa.com',
                                  social_name: 'Roberto Carlos',
                                  department: department,
                                  position: position
                                )

    visit new_user_registration_path
    fill_in 'E-mail', with: employee.email
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'Cpf', with: employee.cpf
    click_on 'Sign up'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso'
    expect(User.last.role).to eq 'employee'
    employee.reload
    expect(employee.user_id).to eq User.last.id
  end

  scenario 'sem sucesso' do
    company = Company.create!(
      brand_name: 'Campus Code', corporate_name: 'Campus Code Treinamentos LTDA',
      registration_number: '00.394.460/0058-87', address: 'Rua da tecnologia, nº 1500',
      phone_number: '1130302525', email: 'contato@campuscode.com.br',
      domain: 'campuscode.com.br',
      logo: {
        io: Rails.root.join('spec/support/images/logo.png').open,
        filename: 'logo.png', content_type: 'image/png'
    })
    department = Department.create!(name: 'RH', company: company)
    position = Position.create!(name: 'estagiário', department: department)
    employee = Employee.create!(
                                  cpf: '69142235219',
                                  email: 'funcionario@empresa.com',
                                  social_name: 'Roberto Carlos',
                                  department: department,
                                  position: position
                                )

    visit new_user_registration_path
    fill_in 'E-mail', with: employee.email
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'Cpf', with: '66614254901'
    click_on 'Sign up'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso'
    expect(page).to have_content 'banana'
    expect(User.last.role).to eq 'employee'
    employee.reload
    expect(employee.user_id).to eq User.last.id
  end

end
