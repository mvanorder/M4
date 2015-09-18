class CreateAuthMemberships < ActiveRecord::Migration
  def change
    create_table :auth_memberships do |t|
      t.integer :user_id
      t.integer :auth_group_id

      t.timestamps null: false
    end
  end
end
