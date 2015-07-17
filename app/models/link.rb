class Link < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :topic
  belongs_to :user
  has_and_belongs_to_many :tags 
  has_many :comments 
  has_many :votes, dependent: :destroy
  has_many :voted_by_users, through: :votes, source: :user
  
  validates :title, presence: true, length:{ minimum: 10 }
  validates :url, presence: true

  attr_accessor :tag_tokens

  def related
    Link.joins(:links_tags).where('links_tags.tag_id IN (?)', 
      self.tags.map{|tag| tag.id }).limit(4).where.not(id: self.id)
  end

  def posted_by?(user)
    self.user == user
  end

  def tag_tokens=(tokens) 
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end  
end
