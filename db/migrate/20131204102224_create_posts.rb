class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.references :user
      
      t.timestamps      
    end

    add_index :posts, :user_id
  end
 
  def down
    drop_table :posts
  end
end
