class Admin::BasesController < ApplicationController
  before_action :authenticate_user!, :is_project_manager?

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_find_user"
    redirect_to root_path
  end

  def is_project_manager?
    return if current_user.project_manager?

    flash[:danger] = t "not_permittion"
    redirect_to root_path
  end
end
