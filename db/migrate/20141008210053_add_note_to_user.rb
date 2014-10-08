class AddNoteToUser < ActiveRecord::Migration
  def change
    add_column :users, :note, :string, null: false, default: ''
  end
end
