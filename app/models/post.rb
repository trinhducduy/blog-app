require 'elasticsearch/model'

class Post < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mount_uploader :cover_image, ImageUploader
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :votes, dependent: :destroy
  has_many :voted_by_users, through: :votes, source: :user 

  validates :title, presence: true, length:{ minimum: 10 }
  validates :excerpt, presence: true
  validates :content, presence: true, length:{ minimum: 100 }
  validates :cover_image, presence: true

  attr_accessor :tag_tokens
  
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title
      indexes :excerpt
      indexes :content
    end
  end

  def posted_by?(user)
    self.user == user
  end

  def tag_tokens=(tokens) 
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'excerpt', 'content']
          }
        },
        highlight: {
          pre_tags: ['<em class="highlight">'],
          post_tags: ['</em>'],
          fields: {
            title: {},
            excerpt: {},
            content: {}
          }
        }
      }
    )
  end
end

Post.import