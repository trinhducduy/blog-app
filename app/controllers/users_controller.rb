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

  def finish_signup
    if @user && !@user.email_verified?
      if request.patch? && params[:user] 
        if @user.update(user_params)
          sign_in(@user, bypass: true)
          redirect_to root_path, notice: 'Successfully authenticated from Twitter.'
        else
          render :finish_signup
        end
      end
    else
      redirect_to root_path
    end
  end

  private 
  
  def set_user
    @user = User.friendly.find(params[:id])
  end 

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end

end

