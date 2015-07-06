class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :posts_tags, id: false do |t|
      t.integer :post_id
      t.integer :tag_id
    end

    add_index :posts_tags, :post_id
    add_index :posts_tags, :tag_id
    add_index :posts_tags, [:post_id, :tag_id], unique: true
  end
end
