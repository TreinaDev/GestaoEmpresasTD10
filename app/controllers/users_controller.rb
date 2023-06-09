class UsersController < ApplicationController
  before_action :find_user, only: [:block, :unblock]
  before_action :authorize_admin


  def index
    @users = User.where(role: 'manager')
  end

  def block
    if @user.block!
      redirect_to users_path, alert: 'Usuário Bloqueado.'
    else
      redirect_to users_path, alert: 'Não foi possível bloquear o usuário'
    end
  end

  def unblock
    if @user.unblock!
      redirect_to users_path, notice: 'Usuário Desbloqueado'
    else
      redirect_to users_path, alert: 'Não foi possível desbloquear o usuário'
    end
  end
  



  private

  def find_user
    @user = User.find(params[:id])
  end
end