class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.references :user, index: true
      t.integer :vote_count, default: 0
      t.string :cover_image

      t.timestamps null: false
    end
    add_foreign_key :posts, :users
  end
end
