class VotesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource
  
  def index
  end

  def create
    vote_type = params[:type]
    
    if vote_type == 'posts'
      object = Post.find(params[:post_id])
    elsif vote_type == 'links'
      object = Link.find(params[:link_id])
    end
      
    current_user.vote(:post, object)
    redirect_to :back
  end

  def destroy
    vote_type = params[:type]

    if vote_type == 'posts'
      object = Vote.find(params[:id]).post
    elsif vote_type == 'links'
      object = Vote.find(params[:id]).link
    end

    current_user.unvote(:post, object)
    redirect_to :back
  end
end
