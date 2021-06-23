class ChangeDataType < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :category_name, :int
    add_column :posts, :category_name, :string
  end
end
