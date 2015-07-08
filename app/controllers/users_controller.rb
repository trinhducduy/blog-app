class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :authenticate_user!, except: [:show]

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def show
    @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('created_at DESC')
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

