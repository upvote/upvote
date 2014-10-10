class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [ :show, :edit, :update, :destroy, :outbound, :upvote ]
  before_action :set_user, only: [ :submitted_by_user, :liked_by_user ]

  # GET /posts
  # GET /posts.json
  def index
    page = params[:page] || 1

    @posts = Post::Base.order('created_at DESC').all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  def submitted_by_user
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
    # do something here, like track it
    redirect_to @post.url
  end

  # GET /posts/new
  def new
    @post = Post::Base.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post::Base.new post_params.merge(user:current_user)

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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_comments_path(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: post_comments_path(@post) }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post::Base.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :url)
    end
end
