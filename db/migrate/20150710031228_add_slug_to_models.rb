class AddSlugToModels < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_column :posts, :slug, :string
    add_column :tags, :slug, :string

    add_index :posts, :slug, unique: true
    add_index :tags, :slug, unique: true
    add_index :users, :slug, unique: true
  end
end
