class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale
  protect_from_forgery with: :exception

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def current_user_is_teacher_or_admin
    return if current_user.teacher? || current_user.admin?

    flash[:danger] = t "not_permittion"
    redirect_to root_path
  end

  def current_user_is_admin
    return if current_user.admin?

    flash[:danger] = t "not_permittion"
    redirect_to root_path
  end
end
