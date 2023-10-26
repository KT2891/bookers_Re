class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.active_relationships.create(followed_id: @user.id)
    currentUserEntry = Entry.where(user_id: current_user.id)
    userEntry = Entry.where(user_id: @user.id)
    unless @user == current_user
      currentUserEntry.each do |a_user|
        userEntry.each do |b_user|
          if a_user.room_id == b_user.room_id
            @isRoom = true
            @roomId = a_user.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.active_relationships.find_by(followed_id: @user.id).destroy
  end

  def following
    @user = User.find(params[:user_id])
  end

  def followers
    @user = User.find(params[:user_id])
  end
end



params[:id]
@comment = BookComment.find(params[:id])
@book = book.comments
