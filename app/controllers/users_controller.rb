class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    if logged_in?
      if @user[:id] == current_user[:id]
        render 'edit'
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user[:id] == current_user[:id]
      @user = User.find(params[:id])
    else
      render 'show'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "Welcome to M4!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    binding.pry
    if @user.update_attributes(user_params)
      #redirect_to @user
      flash.now[:success] = "Successfully updated profile"
      render 'edit'
    else
      flash.now[:danger] = "Failed to updated profile"
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :username, :bio,
                                   auth_memberships_attributes: [:id, :auth_group_id, :_destroy])
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
