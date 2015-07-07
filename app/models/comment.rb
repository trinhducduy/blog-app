class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :parent
  has_many :children, class_name: 'Comment', 
                      foreign_key: 'parent_id',
                      dependent: :destroy
end
