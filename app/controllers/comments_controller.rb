class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_post

  def index
    @comments = @post.comment_threads
    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end

  def create
    @post.comment_threads.create!(comment_params.merge user: current_user)
    redirect_to post_comments_path(@post)
  end

  protected

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post::Base.friendly.find params[:post_id] || params[:id]
  end
end
