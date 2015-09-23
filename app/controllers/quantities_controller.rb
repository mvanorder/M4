class QuantitiesController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :admin_user, only: [:index, :new, :edit, :create, :update, :destroy]

  def index
    @quantities = Quantity.all
  end

  def new
    @quantity = Quantity.new
  end

  def edit
    @quantity = Quantity.find(params[:id])
  end

  def create
    @quantity = Quantity.new(quantity_params)

    if @quantity.save
      redirect_to admin_quantities_path
    else
      render 'new'
    end
  end

  def update
    @quantity = Quantity.find(params[:id])
    if @quantity.update_attributes(quantity_params)
      redirect_to admin_quantities_path
    else
      flash.now[:danger] = "Failed to updated quantity"
      render 'edit'
    end
  end

  private
    def quantity_params
      params.require(:quantity).permit(:name, :abbreviation, :quantity_type, :multiplier)
    end
end
