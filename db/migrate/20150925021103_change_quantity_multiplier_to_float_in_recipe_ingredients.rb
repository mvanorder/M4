class ChangeQuantityMultiplierToFloatInRecipeIngredients < ActiveRecord::Migration
  def change
    change_column :recipe_ingredients, :quantity_multiplier, :float
  end
end
