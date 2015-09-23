class AddQuantityTypeToQuantities < ActiveRecord::Migration
  def change
    add_column :quantities, :quantity_type, :integer
    remove_column :quantities, :type, :integer
  end
end
