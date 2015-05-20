class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  alias_method :logged_in?, :user_signed_in?
  alias_method :signed_in?, :user_signed_in?

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render text: 'Not Found', status: 404
  end

  layout :resolve_layout

  helper_method :logged_in?

  protected

  def ensure_signup_complete
    return if action_name == 'finish_signup' # ensure we don't go into an infinite loop
    return redirect_to(finish_signup_path current_user) if current_user && !current_user.email_verified?
  end

  def resolve_layout
    request.xhr? ? false : 'application'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :headline
  end

end
