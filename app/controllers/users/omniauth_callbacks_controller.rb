class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.save! unless @user.persisted?

    set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    sign_in_and_redirect @user, event: :authentication
  end

  def failure
    redirect_to root_path
  end
end
