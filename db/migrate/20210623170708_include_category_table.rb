class IncludeCategoryTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :category_name, :string
    add_column :posts, :category_id, :int
  end
end
