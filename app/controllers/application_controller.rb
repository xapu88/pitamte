class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  after_filter :store_location

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def store_location
	  # store last url as long as it isn't a /users path
	  session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
	end

	def after_sign_in_path_for(resource)
		if resource.class == AdminUser
			return admin_root_path
		else
	  	session[:previous_url] || root_path
	  end
	end

  private

	  def user_not_authorized
	    flash[:alert] = "Nisi ovlascen za ovu opciju (zasticeno od strane admina)."
	    redirect_to(request.referrer || root_path)
	  end
end
