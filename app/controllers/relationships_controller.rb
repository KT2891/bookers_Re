class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    current_user.active_relationships.create(followed_id: @user.id)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.active_relationships.find_by(followed_id: @user.id).destroy
  end

  def following
  end

  def followers
  end

end
