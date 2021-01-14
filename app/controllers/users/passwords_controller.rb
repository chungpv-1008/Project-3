class Users::PasswordsController < DeviseController
  append_before_action :assert_reset_token_passed, only: :edit

  def new
    self.resource = resource_class.new
    render "devise/passwords/new"
  end

  def create
    self.resource = resource_class.send_reset_password_instructions resource_params
    yield resource if block_given?
    flash[:danger] = t ".failed" unless successfully_sent? resource
    redirect_to root_path and return
  end

  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
    render "devise/passwords/edit"
  end

  def update
    self.resource = resource_class.reset_password_by_token resource_params
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        flash[:success] = t ".success"
        resource.after_database_authentication
        sign_in resource_name, resource
      else
        flash.now[:danger] = t ".failed"
      end
      redirect_to profile_path
    else
      set_minimum_password_length
      flash.now[:danger] = t ".failed"
      render "devise/passwords/edit"
    end
  end

  protected
    def after_resetting_password_path_for(resource)
      Devise.sign_in_after_reset_password ? after_sign_in_path_for(resource) : new_session_path(resource_name)
    end

    def after_sending_reset_password_instructions_path_for(resource_name)
      new_session_path(resource_name) if is_navigational_format?
    end

    def assert_reset_token_passed
      if params[:reset_password_token].blank?
        set_flash_message(:alert, :no_token)
        redirect_to new_session_path(resource_name)
      end
    end

    def unlockable?(resource)
      resource.respond_to?(:unlock_access!) &&
        resource.respond_to?(:unlock_strategy_enabled?) &&
        resource.unlock_strategy_enabled?(:email)
    end

    def translation_scope
      'users.passwords'
    end
end
