class AddMetaToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :meta, :text
  end
end
