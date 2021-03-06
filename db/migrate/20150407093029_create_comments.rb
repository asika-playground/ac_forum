class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
        t.text :content, :null => false

        t.integer :topic_id, :null => false

      t.timestamps null: false
    end

    add_index :comments, :topic_id
  end
end
