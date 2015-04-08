class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
        t.string :topic, :null => false
        t.text   :content, :null => false

      t.timestamps null: false
    end
  end
end
