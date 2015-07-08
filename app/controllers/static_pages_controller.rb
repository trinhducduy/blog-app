class StaticPagesController < ApplicationController
  authorize_resource class: false

  def home
    @posts = Post.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def help
  end
end
