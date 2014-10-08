module ApplicationHelper

  def login_url
    user_omniauth_authorize_url(provider:'twitter')
  end

  def login_path
    user_omniauth_authorize_path(provider:'twitter')
  end

end
