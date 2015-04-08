class TopicRenameTitle < ActiveRecord::Migration
  def change
    rename_column :topics, :topic, :title
  end
end
