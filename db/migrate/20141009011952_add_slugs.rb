class AddSlugs < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string, unique: true
    add_column :users, :slug, :string, unique: true
  end
end
