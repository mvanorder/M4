class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to @ingredient
    else
      render 'new'
    end
  end

  def update
    @ingredient = Ingredient.find(params[:id])

    if @ingredient.update(ingredient_params)
      redirect_to @ingredient
    else
      render 'edit'
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.recipes.empty?
      @ingredient.destroy
    else
      error_msg = "Cannot delete #{@ingredient.name} as it is in use by the following recipes: \n"
      @ingredient.recipes.each do |recipe|
        error_msg << "<br />"
        error_msg << recipe.name
      end
      flash[:danger] = error_msg
#      flash[:danger] = "#{@ingredient.name} is in use by #{@ingredient.recipes}" 
    end
    redirect_to ingredients_path
  end

  private
    def ingredient_params
      params.require(:ingredient).permit(:name, :description)
    end

end
