class GroupsController < ApplicationController
  before_action :is_group_owner_matching, only: [:edit, :update]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    if @group.users.include?(current_user)
      @joinGroup = true
    end
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "successfully"
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def create
    @group = Group.new(group_params)
    @group_user = @group.group_users.build(user_id: current_user.id)
    if @group.save
      flash[:notice] = "successfully"
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:id]).destroy
    flash[:notice] = "successfully"
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :owner_id)
  end

  def is_group_owner_matching
    @group = Group.find(params[:id])
    unless @group.owner == current_user
      redirect_to groups_path
    end
  end
end
