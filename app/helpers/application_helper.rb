module ApplicationHelper
  def handle_for_user(user)
    auth     = user.first_authorization
    provider = auth.provider
    link_to submitted_user_posts_path(user) do
      icon(provider) + ' ' + icon(:'angle-right') + ' ' +
        content_tag(:span, user.handle)
    end
  end
end
