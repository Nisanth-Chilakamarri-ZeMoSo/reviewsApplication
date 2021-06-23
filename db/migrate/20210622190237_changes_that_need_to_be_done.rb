class ChangesThatNeedToBeDone < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :movie_id,:int
    add_column :posts, :category_id, :int
    add_column :posts, :item_id, :int
    create_table :categories do |t|
      t.string :category_name
    end 
  end
end
