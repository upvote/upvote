class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title,    null: false
      t.integer :user_id, null: false
      t.string :type,     null: false, default: 'Post::Base'
      t.text :description
      t.string :url
      t.timestamps
    end

    add_index :posts, :user_id
  end
end
