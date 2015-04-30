class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :outbound, :submitted_by_user, :liked_by_user]
  before_action :set_date, only: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :outbound, :upvote]
  before_action :set_user, only: [:submitted_by_user, :liked_by_user]

  # TODO: add pagination and infinite scroll support!
  def index
    @posts = Post::Base.order('created_at DESC')

    if @date
      @posts = @posts.on_date(@date)
    end

    if params[:tag].present?
      @posts = @posts.tagged_with(params[:tag])
    end

    @posts = @posts.group_by { |p| p.created_at.to_date }
  end

  def submitted_by_user
    @posts = Post::Base.where user: @user
    render :index
  end

  def liked_by_user
    @posts = @user.find_up_voted_items
    render :index
  end

  def upvote
    current_user.up_votes(@post)
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Successfully voted!' }
    end
  end

  def outbound
    @post.clicks.create! user: current_user
    redirect_to @post.url
  end

  # GET /posts/new
  def new
    @post = Post::Base.new
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post::Link.new post_params.merge user: current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_comments_path(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: post_path(@post) }
      else
        handle_post_error format, :new
      end
    end
  end

  private

  def set_date
    return unless params[:year] && params[:month] && params[:day]
    @date = Date.strptime("#{params[:year]}-#{params[:month]}-#{params[:day]}")
  end

  def handle_post_error(format, action = :edit)
    format.html { render action }
    format.json { render json: @post.errors, status: :unprocessable_entity }
  end

  def set_user
    @user = User.friendly.find(params[:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post::Base.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :description, :url, :tag_list)
  end
end
