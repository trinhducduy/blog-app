class TagsController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  
  def index
    @tags = Tag.tokens(params[:q])

    respond_to do |format|
      format.html
      format.json { render :json => @tags }
    end
  end
end
