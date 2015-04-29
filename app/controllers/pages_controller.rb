class PagesController < ApplicationController
  before_filter :redirect_if_logged_in, only: :login

  protected

  def redirect_if_logged_in
    redirect_to root_path if user_signed_in?
  end

end
