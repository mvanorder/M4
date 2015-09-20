class AddIndexToAuthMemerships < ActiveRecord::Migration
  def change
    add_index :auth_memberships, :user_id
    add_index :auth_memberships, :auth_group_id
    add_index :auth_memberships, [:user_id, :auth_group_id], unique: true
  end
end
