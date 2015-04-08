class AddUserToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :user_id, :integer
    change_column :topics, :user_id, :integer, :null => false
    add_index :topics, :user_id
  end
end
