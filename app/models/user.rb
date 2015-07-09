class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader

  has_many :active_relationships, class_name: 'Relationship', 
                                  foreign_key: 'follower_id', 
                                  dependent: :destroy
  
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :voting_posts, through: :votes, source: :post

  has_many :following, through: :active_relationships, source: :followed
  has_many :followeds, through: :passive_relationships, source: :follower
  has_many :posts

  validates :name, presence: true, length: { minimum: 2 }

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def vote(post)
    votes.create(post_id: post.id)
  end

  def unvote(post)
    votes.find_by(post_id: post.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
  
  def voting?(post)
    voting_posts.include?(post)
  end
end
