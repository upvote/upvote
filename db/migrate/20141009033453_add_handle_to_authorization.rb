class AddHandleToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :handle, :string
  end
end
