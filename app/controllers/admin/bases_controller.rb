class Admin::BasesController < ApplicationController
  before_action :authenticate_user!, :is_admin?

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_find_user"
    redirect_to root_path
  end

  def is_admin?
    return if current_user.admin?

    flash[:danger] = t "not_permittion"
    redirect_to root_path
  end
end
