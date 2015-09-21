class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :admin_user, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user[:id] == current_user[:id] || is_admin?
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
    if @user.update_attributes(user_params)
      #redirect_to @user
      flash.now[:success] = "Successfully updated profile"
      render 'edit'
    else
      flash.now[:danger] = "Failed to updated profile"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :username, :bio,
                                   auth_memberships_attributes: [:id, :auth_group_id, :_destroy])
    end

end
