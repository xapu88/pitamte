class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # You should also create an action method in this controller like this:
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user, note: "Prijava preko Facebook-a uspela!"
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

  #protected

  # The path used when omniauth fails
  #def after_omniauth_failure_path_for(scope)
  #  super(scope)
  #end
end
