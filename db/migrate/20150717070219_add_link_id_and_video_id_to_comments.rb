class AddLinkIdAndVideoIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :link_id, :integer
    add_column :comments, :video_id, :integer
    add_index :comments, :link_id
    add_index :comments, :video_id
  end
end
