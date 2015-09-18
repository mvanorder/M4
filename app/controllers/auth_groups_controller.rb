class AuthGroupsController < ApplicationController
  def index
    @auth_groups = AuthGroup.all
  end

  def new
    @auth_group = AuthGroup.new
  end

  def edit
    @auth_group = AuthGroup.find(params[:id])
  end

  def create
    @auth_group = AuthGroup.new(auth_group_params)

    if @auth_group.save
      redirect_to admin_authgroups_path
    else
      render 'new'
    end
  end

  def update
    @auth_group = AuthGroup.find(params[:id])

    if @auth_group.update(auth_group_params)
      redirect_to admin_authgroups_path
    else
      render 'edit'
    end
  end

  def destroy
    @auth_group = AuthGroup.find(params[:id])
    @auth_group.destroy

    redirect_to admin_authgroups_path
  end


  private
    def auth_group_params
      params.require(:auth_group).permit(:name, :description)
    end
end
