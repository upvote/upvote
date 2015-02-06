class CreatePostClicks < ActiveRecord::Migration
  def change
    create_table :post_clicks do |t|
      t.belongs_to :user, index: true, null: true # allow anonymous click counts
      t.belongs_to :post, index: true, null: false
      t.timestamps
    end
    add_column :posts, :clicks_count, :integer, default: 0, null: false
    add_index :posts, :clicks_count
  end
end
