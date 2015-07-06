class VotesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user.vote(post)
    redirect_to post
  end

  def destroy
    post = Vote.find(params[:id]).post
    current_user.unvote(post)
    redirect_to post
  end
end
