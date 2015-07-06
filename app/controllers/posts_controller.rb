class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  autocomplete :tag, :name

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def show
  end

  def search 
    if params[:q].nil?
      @posts = []
    else
      @posts = Post.search(params[:q]).records
    end

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy(post_params)
    redirect_to posts_url, notice: 'Post was successfully deleted'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :cover_image, :title, 
      :excerpt, :tag_tokens)
  end

end
