module UserHelper
  def admin?
    user_signed_in? && current_user.admin?
  end

  def manager?
    user_signed_in? && current_user.manager?
  end

  def employee?
    user_signed_in? && current_user.is_employee?
  end
end
