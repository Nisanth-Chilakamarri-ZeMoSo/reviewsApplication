class Addcolumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :category_id, :int
    add_column :posts, :category_name, :int
  end
end
