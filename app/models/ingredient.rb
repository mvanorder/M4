class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  accepts_nested_attributes_for :recipes
  accepts_nested_attributes_for :recipe_ingredients
  
  def ingredient_name
    try(:name)
  end

  def ingredient_name=(name)
    Ingredient.find_by_name(name) if name.present?
    binding.pry
  end
end
