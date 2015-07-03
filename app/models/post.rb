class Post < ActiveRecord::Base
  mount_uploader :cover_image, ImageUploader
  belongs_to :user
  validates :title, presence: true, length:{ minimum: 10 }
  validates :excerpt, presence: true
  validates :content, presence: true, length:{ minimum: 100 }
  validates :cover_image, presence: true

  def posted_by? user
    self.user == user
  end
end
