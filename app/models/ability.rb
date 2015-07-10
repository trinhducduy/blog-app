class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      # all users
      can :manage, :static_page
      can [:read, :create], :all
      can :search, Post
      can :reply, Comment
      
      # owner users
      can [:edit, :update, :destroy], Post, :user_id => user.id
      can :destroy, Relationship, :follower_id => user.id
      can [:edit, :update, :destroy], User, :id => user.id
      can :destroy, Vote, :user_id => user.id
      can :destroy, Comment, :user_id => user.id
    end
  end

end
