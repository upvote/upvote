class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :user_id, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.text :meta
      t.timestamps
    end
    add_index :authorizations, [ :provider, :uid ],     unique: true # UID must be unique to provider
    add_index :authorizations, [ :provider, :user_id ], unique: true # only 1 login per user
  end
end
