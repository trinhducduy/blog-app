class CommentsController < ApplicationController
  authorize_resource
  before_action :set_comment, only: [:update, :destroy, :reply]
  before_action :authenticate_user!
  
  def create
    comment_type = params[:comment][:type]

    if comment_type == 'posts'
      object = Post.friendly.find(params[:post_id])    
    elsif comment_type == 'links'
      object = Link.friendly.find(params[:link_id])
    end

    @comment = object.comments.new(comment_params)
    @comment.user = current_user
    
    @comment.save
    redirect_to :back
  end

  def update
    @comment.update(commment_params)
    redirect_to :back, notice: 'Comment was update successfully'  
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end

  def reply
    @child = @comment.children.new(comment_params)
    @child.user = current_user
    @child.save
    redirect_to :back
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
