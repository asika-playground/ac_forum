class CreateTopicCateShips < ActiveRecord::Migration
  def change
    create_table :topic_cate_ships do |t|
        t.integer :topic_id
        t.integer :category_id

      t.timestamps null: false
    end

    add_index :topic_cate_ships, :topic_id
    add_index :topic_cate_ships, :category_id
  end
end
