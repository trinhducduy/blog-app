class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.string :slug
      t.references :topic, index: true
      t.references :user, index: true

      t.timestamps null: false
    end

    create_table :links_tags, id: false do |t|
      t.integer :link_id
      t.integer :tag_id
    end

    add_foreign_key :links, :topics
    add_index :links_tags, :link_id
    add_index :links_tags, :tag_id
    add_index :links_tags, [:link_id, :tag_id], unique: true
  end
end
