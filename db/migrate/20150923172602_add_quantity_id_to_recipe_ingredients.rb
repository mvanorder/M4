class AddQuantityIdToRecipeIngredients < ActiveRecord::Migration
  def change
    add_column :recipe_ingredients, :quantity_id, :integer
  end
end
