class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.string :name
      t.integer :type
      t.float :multiplier

      t.timestamps null: false
    end
    add_index :quantities, :name
  end
end
