class TopicsAddLastUpdate < ActiveRecord::Migration
  def change
    add_column :topics, :last_update, :timestamp
  end
end
