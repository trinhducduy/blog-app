class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update]

  def index
    @links = Link.all
  end

  def show
    @comments = @link.comments.paginate(page: params[:page], per_page: 5)
    @comment = Comment.new
    @related_links = @link.related
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.user = current_user
    if @link.save
      flash[:notice] = "Link was successfully created!"
      redirect_to @link
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @link.update(link_params)
      flash[:notice] = "Link was successfully updated!"
      redirect_to @link
    else
      render :edit
    end
  end

  protected

  def set_link
    @link = Link.friendly.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :url, :topic_id, :tag_tokens)
  end

end
