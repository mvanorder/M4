class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  accepts_nested_attributes_for :ingredient,
                                :reject_if => :all_blank
  accepts_nested_attributes_for :recipe
end
