class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts
  scope :popular, -> {
      select("tags.id, tags.name, COUNT(tags.id) AS tags_count").
      joins(:tags_posts).
      group("tags.id").
      order("tags_count DESC").
      limit(10)
    }

  def self.tokens(query)
    tags = where("name like ?", "%#{query}%") 
    if tags.empty?
      [{id: "<<<#{query}>>>", name: "New: #{query}"}]
    else
      tags.map(&:attributes)
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

  def popular 
  end

end
