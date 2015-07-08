class CommentsController < ApplicationController
  authorize_resource
  before_action :set_comment, only: [:update, :destroy]
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to @post
    else
      render :new
    end
  end

  def update
    if @comment.update(commment_params)
      redirect_to @post, notice: 'Comment was create successfully'
    else
      render :edit
    end  
  end

  def destroy
    @comment.destroy
    redirect_to @post
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
