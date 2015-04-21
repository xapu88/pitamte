class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # You should also create an action method in this controller like this:
  def facebook
    auth = env["omniauth.auth"]
    provider = auth["provider"]
    uid = auth["uid"]
    data = auth["info"]
    credentials = auth["credentials"]
    token = credentials["token"]

    if !current_user.blank?
      binding = User.find_binding(provider, uid)

      if binding.present?
        binding.refresh_token(token)
      else
        current_user.bind_service(provider, uid, token)
      end

      redirect_to setting_path, :notice => "Bind facebook account successfully."
    else
      @user = User.find_or_create_for_facebook(uid, data, token)
      sign_in_and_redirect @user, :event => :authentication, :notice => "Signed in successfully."
    end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
