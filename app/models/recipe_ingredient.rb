class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  #validates_presence_of :ingredient_id, :recipe_id
  accepts_nested_attributes_for :ingredient,
                                :reject_if => :all_blank
  accepts_nested_attributes_for :recipe
end
