require 'rails_helper'

feature 'visitante visita página de perfil' do
  scenario 'com sucesso' do
    company = create(:company)
    department = create(:department, company:)
    position = create(:position, department:)

    employee_data = create(:employee_profile, :employee, department: , position:, email: 'funcionario@empresa.com', cpf: '69142235219')
    
    employee_user = User.create!(email: employee_data.email,cpf: employee_data.cpf,password: '123456')

    login_as employee_user

    visit profile_users_path

    expect(page).to have_content('Roberto Carlos Nascimento')
    expect(page).to have_content('Nome Social: Roberto Carlos')
    expect(page).to have_content('E-mail: funcionario@empresa.com')
    expect(page).to have_content('Data de Nascimento: 06/06/2023')
    expect(page).to have_content('CPF: 69142235219')
    expect(page).to have_content('RG: 12345678901')
    expect(page).to have_content('Telefone: 1199776655')
    expect(page).to have_content('Endereço: Rua do funcionário, 1200')
    expect(page).to have_content('Estado Civil: Solteiro(a)')
    expect(page).to have_content('Data de Admissão: 06/06/2023')
    expect(page).to have_content("Departamento: #{department.name}")
    expect(page).to have_content("Cargo: #{position.name}")
  end
end
