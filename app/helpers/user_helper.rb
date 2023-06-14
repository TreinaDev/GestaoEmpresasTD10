module UserHelper
  def admin?
    user_signed_in? && current_user.admin?
  end

  def manager?
    user_signed_in? && current_user.manager?
  end
end
