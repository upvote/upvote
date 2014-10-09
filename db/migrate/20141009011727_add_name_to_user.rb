class AddNameToUser < ActiveRecord::Migration
  def change
    rename_column :users, :note, :headline
    add_column :users, :name, :string, null: false, default: ''
  end
end
