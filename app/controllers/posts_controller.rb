class PostsController < ApplicationController
  authorize_resource
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]

  autocomplete :tag, :name

  def index
    @posts = Post.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def show
    @comments = @post.comments.paginate(page: params[:page], per_page: 10).order('created_at DESC')
    @comment = Comment.new
    @related_posts = @post.related
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
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :cover_image, :title, 
      :excerpt, :tag_tokens, :bootsy_image_gallery_id)
  end

end
