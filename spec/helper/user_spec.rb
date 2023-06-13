require 'rails_helper'

RSpec.describe UserHelper, type: :helper do
  describe '#admin?' do
    it 'retorna true quando é administrador' do
      user = create(:user, email: 'admin@punti.com')
      allow(helper).to receive(:user_signed_in?).and_return(true)
      allow(helper).to receive(:current_user).and_return(user)
      expect(helper.admin?).to eq(true)
    end

    it 'retorna false quando não é administrador' do
      admin = create(:user, email: 'admin@punti.com')
      company = create(:company, domain: 'qualquer.com')
      create(:manager, email: 'admin@qualquer.com', created_by: admin, company:)
      user = create(:user, email: 'admin@qualquer.com', cpf: '02850181080')
      allow(helper).to receive(:user_signed_in?).and_return(true)
      allow(helper).to receive(:current_user).and_return(user)
      expect(helper.admin?).to eq(false)
    end
  end

  describe '#manager?' do
    it 'retorna true quando é gerente' do
      admin = create(:user, email: 'admin@punti.com', cpf: '02850181080')
      company = create(:company)
      create(:manager, email: 'admin@gmail.com', created_by: admin, company:)
      user = create(:user, email: 'admin@gmail.com', role: :manager)
      allow(helper).to receive(:user_signed_in?).and_return(true)
      allow(helper).to receive(:current_user).and_return(user)
      expect(helper.manager?).to eq(true)
    end

    it 'retorna false quando não é gerente' do
      user = create(:user, email: 'admin@punti.com')
      allow(helper).to receive(:user_signed_in?).and_return(true)
      allow(helper).to receive(:current_user).and_return(user)
      expect(helper.manager?).to eq(false)
    end
  end
end
