class TagsController < ApplicationController

  def index
    @tags = Tag.tokens(params[:q])

    respond_to do |format|
      format.html
      format.json { render :json => @tags }
    end
  end
end
