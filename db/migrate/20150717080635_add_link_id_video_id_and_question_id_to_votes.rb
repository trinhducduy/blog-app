class AddLinkIdVideoIdAndQuestionIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :link_id, :integer
    add_column :votes, :video_id, :integer
    add_column :votes, :question_id, :integer
    add_column :votes, :answer_id, :integer
    
    add_index :votes, :link_id
    add_index :votes, [:user_id, :link_id], unique: true
    add_index :votes, :video_id
    add_index :votes, [:user_id, :video_id], unique: true
    add_index :votes, :question_id
    add_index :votes, [:user_id, :question_id], unique: true
    add_index :votes, :answer_id
    add_index :votes, [:user_id, :answer_id], unique: true
  end
end
