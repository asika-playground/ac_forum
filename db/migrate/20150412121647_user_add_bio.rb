class UserAddBio < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
  end
end
