class ChangesThatNeedToBeDone < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :category_name
    end 
  end
end
