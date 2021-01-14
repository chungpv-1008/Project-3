class Users::SessionsController < Devise::SessionsController
  include Devise::Controllers::Rememberable
  before_action :configure_sign_in_params, if: :devise_controller?
  before_action :load_user, only: :create

  def create
    if @user&.valid_password?(params[:session][:password])
      sign_in @user
      params[:session][:remember_me] == "1" ? remember_me(@user) : forget_me(@user)
      redirect_to root_path
    else
      flash.now[:danger] = t ".invalid_message"
      render :new
    end
  end

  private

  def configure_sign_in_params
    devise_parameter_sanitizer.permit :sign_in,
                                      keys: [:email, :password]
  end

  def load_user
    email = params[:session][:email]
    @user = User.find_by(email: email) if email?(email)
  end
end
