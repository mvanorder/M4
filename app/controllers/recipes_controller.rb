class RecipesController < ApplicationController
  autocomplete :ingredient, :name, :full => true
  before_action :logged_in_user, only: [:new, :edit, :create, :update, :destroy]
  
  def index
    if params[:format]
      @recipes = User.find(params[:format]).recipes
    else
      @recipes = Recipe.all
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @user = current_user
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @user = current_user

    if !params[:recipe][:recipe_ingredients_attributes].nil?
      params[:recipe][:recipe_ingredients_attributes].each do |riid, rivalue|
        if Ingredient.where(name: rivalue[:ingredient_attributes][:name]).take
          params[:recipe][:recipe_ingredients_attributes][riid][:ingredient_id] = Ingredient.where(name: rivalue[:ingredient_attributes][:name]).take.id.to_s
          params[:recipe][:recipe_ingredients_attributes][riid].delete("ingredient_attributes")
        end
      end
    end

    @recipe = @user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    # clean up empty entries
    recipe_params[:recipe_ingredients_attributes].each do |k, v|
      if v[:quantity_multiplier].empty? && v[:ingredient_attributes][:name].empty?
        params[:recipe][:recipe_ingredients_attributes].delete(k)
      end
    end

    # prevent duplicate ingredients
    params[:recipe][:recipe_ingredients_attributes].each do |riid, rivalue|
      # If ingredient is new to the recipe
      if !rivalue[:ingredient_attributes][:id]
        # If ingredient is already in he database
        if Ingredient.where(name: rivalue[:ingredient_attributes][:name]).take
          # Create a params entry for the ingredient_id and remove the create entry
          params[:recipe][:recipe_ingredients_attributes][riid][:ingredient_id] = Ingredient.where(name: rivalue[:ingredient_attributes][:name]).take.id.to_s
          params[:recipe][:recipe_ingredients_attributes][riid].delete("ingredient_attributes")
        end
      else
        #if ingredient was already in the recipe, make sure that the id references the correct ingredient_id
        if Ingredient.where(name: rivalue[:ingredient_attributes][:name]).take
          params[:recipe][:recipe_ingredients_attributes][riid][:ingredient_id] = Ingredient.where(name: rivalue[:ingredient_attributes][:name]).take.id.to_s
          params[:recipe][:recipe_ingredients_attributes][riid].delete("ingredient_attributes")
        end
      end
    end

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :description, :directions, :image,
                                     recipe_ingredients_attributes: [:id, :quantity_multiplier, :quantity_id, :ingredient_id, :_destroy,
                                                                     ingredient_attributes: [:id, :ingredient_name, :name]])
    end
end
