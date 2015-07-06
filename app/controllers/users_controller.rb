class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def show
    @posts = @user.posts
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Your profile was successfully updated'
    else
      render :edit
    end
  end

  private 
  
  def set_user
    @user = User.find(params[:id])
  end 

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

end
