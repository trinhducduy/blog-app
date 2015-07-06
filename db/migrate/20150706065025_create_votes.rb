class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :post_id
      t.timestamps null: false
    end
    
    add_index :votes, :user_id
    add_index :votes, :post_id
    add_index :votes, [:user_id, :post_id], unique: true
  end
end
