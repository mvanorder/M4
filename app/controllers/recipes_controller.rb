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
                                                                     ingredient_attributes: [:id, :ingredient_name, :name],
                                                                     ingredient: [:id, :ingredient_name]])
    end
end
