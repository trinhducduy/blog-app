class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, 
         omniauth_providers: [:facebook, :twitter]
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
  has_many :posts, dependent: :destroy

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

  def self.from_omniauth(auth)
    auth.info.email ||= 'let@change.me'
    puts auth.info.email    
    
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.avatar = auth.info.image
    end
  end

  def email_verified?
    self.email && self.email != 'let@change.me'
  end
end
