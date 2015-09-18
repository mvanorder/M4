class CreateAuthGroups < ActiveRecord::Migration
  def change
    create_table :auth_groups do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
    add_index :auth_groups, :name
  end
end
