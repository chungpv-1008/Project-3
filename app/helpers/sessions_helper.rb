module SessionsHelper
  def email? email
    Settings.user.email_regex === email
  end

  def arr_user_roles
    User.roles.first(2).map do |id, key|
      [id, key]
    end
  end

  def current_user? user
    user && current_user == user
  end

  def role_user user
    case user.role
    when "admin"
      Settings.user.admin
    when "normal"
      Settings.user.normal
    when "teacher"
      Settings.user.teacher
    end
  end

  def correct_user? course
    current_user.admin? || current_user == course.user
  end
end
