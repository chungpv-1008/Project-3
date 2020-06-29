class UsersController < ApplicationController
  include Devise::Controllers::Rememberable

  before_action :authenticate_user!
  before_action :load_user, :correct_user, only: %i(show edit update)

  def show; end

  def edit; end

  def update
    if @user.update users_params_update
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to profile_edit_path
  end

  def about; end

  private

  def users_params_update
    params.require(:user).permit User::USER_PARAMS_UPDATE
  end

  def load_user
    @user = if params[:id].present?
              User.find_by id: params[:id]
            else
              current_user
            end
    return if @user

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t ".not_permittion"
    redirect_to root_path
  end
end
