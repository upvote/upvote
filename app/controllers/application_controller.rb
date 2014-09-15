class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  alias_method :logged_in?, :user_signed_in?
  alias_method :signed_in?, :user_signed_in?

  helper_method :logged_in?

end
