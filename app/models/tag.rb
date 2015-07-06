class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts

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

end
