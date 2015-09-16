class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    #@user = current_user
    #@recipe = @user.recipe.find(params[:id])
    @recipe = Recipe.find(params[:id])
  end

  def new
    @user = current_user
    #@recipe = @user.recipe.build
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @user = current_user
    @recipe = @user.recipes.build(recipe_params)
    #@recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def update
    binding.pry
    @recipe = Recipe.find(params[:id])

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
                                     recipe_ingredients_attributes: [:id, :ingredients_id, :recipe_id, :_destroy],
                                     ingredients_attributes: [:id, :name, :_destroy])
    end
end
