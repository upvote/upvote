class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  alias_method :logged_in?, :user_signed_in?
  alias_method :signed_in?, :user_signed_in?

  helper_method :logged_in?

  def ensure_signup_complete
    return if action_name == 'finish_signup' # Ensure we don't go into an infinite loop

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
  
end
