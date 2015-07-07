class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :parent_id
      t.references :user, index: true
      t.references :post, index: true
      t.timestamps null: false
    end
    add_index :comments, :parent_id
    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
  end
end
