FactoryBot.define do
  factory :user do
    password { 'password' }
    cpf { '94462646690' }

    factory :admin_user do
      email { 'admin@punti.com' }
      cpf { '69142235219' }
    end

    factory :manager_user do
      email { 'manager@microsoft.com' }
      cpf { '15703243017' }
    end

    factory :employee_user do
      email { 'employee@microsoft.com' }
      cpf { '29963810926' }
    end
  end
end
