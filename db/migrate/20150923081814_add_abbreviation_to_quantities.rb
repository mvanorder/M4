class AddAbbreviationToQuantities < ActiveRecord::Migration
  def change
    add_column :quantities, :abbreviation, :string
  end
end
