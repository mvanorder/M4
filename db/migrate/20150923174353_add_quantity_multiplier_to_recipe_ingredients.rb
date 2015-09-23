class AddQuantityMultiplierToRecipeIngredients < ActiveRecord::Migration
  def change
    add_column :recipe_ingredients, :quantity_multiplier, :integer
  end
end
