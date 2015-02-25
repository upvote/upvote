class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :outbound]
  before_action :set_date, only: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :outbound, :upvote]
  before_action :set_user, only: [:submitted_by_user, :liked_by_user]

  # TODO: add pagination and infinite scroll support!
  def index
    @posts = Post::Base.order('created_at DESC')
    @posts = @posts.where("posts.created_at > ? AND posts.created_at < ?", @date, @date+1.day) if @date
    @posts = @posts.tagged_with(params[:tag]) if params[:tag].present?
    @posts = @posts.group_by { |p| p.created_at.to_date }
  end

  def show
  end

  def submitted_by_user
    @posts = Post::Base.where user: @user
    render :index
  end

  def liked_by_user
  end

  def upvote
    @post.liked_by current_user
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
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_date
      return unless params[:year] && params[:month] && params[:day]
      @date = Date.strptime("#{params[:year]}-#{params[:month]}-#{params[:day]}")
    end

    def handle_post_error(format,action=:edit)
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
