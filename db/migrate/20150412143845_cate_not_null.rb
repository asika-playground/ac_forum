class CateNotNull < ActiveRecord::Migration
  def change
    change_column :categories, :name, :string, :null => false
  end
end
