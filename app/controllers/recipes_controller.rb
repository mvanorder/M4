class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
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
    binding.pry
    @user = current_user
    #@recipe = Recipe.new(recipe_params)
    params[:recipe][:recipe_ingredients_attributes].each do |riid, rivalue|
      if Ingredient.where(name: rivalue[:ingredient_attributes][:name]).take
        params[:recipe][:recipe_ingredients_attributes][riid][:ingredient_id] = Ingredient.where(name: rivalue[:ingredient_attributes][:name]).take.id.to_s
        params[:recipe][:recipe_ingredients_attributes][riid].delete("ingredient_attributes")
      end
    end
    
    @recipe = @user.recipes.build(recipe_params)

    binding.pry
    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    params[:recipe][:recipe_ingredients_attributes].each do |riid, rivalue|
      if !rivalue[:ingredient_attributes][:id]
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
                                     recipe_ingredients_attributes: [:id, :ingredient_id, :_destroy,
                                                                     ingredient_attributes: [:id, :name]])
    end
end
