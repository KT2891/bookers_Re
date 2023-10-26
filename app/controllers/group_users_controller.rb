class GroupUsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.create(user_id: current_user.id, group_id: @group.id)
    redirect_to group_path(@group)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.find_by(group_id: @group.id, user_id: current_user.id)
    @group_user.destroy
    redirect_to groups_path
  end
end
