class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { admin: 0, manager: 1, employee: 2 }, _default: :employee
  before_save :set_admin_role

  def description
    "#{role.upcase}: #{email}"
  end

  private

  def set_admin_role
    self.role = 'admin' if email.match?('@punti.com')
  end
end
