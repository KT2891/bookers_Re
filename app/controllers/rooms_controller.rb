class RoomsController < ApplicationController

  def create
    @room = Room.create
    Entry.create(room_id: @room.id, user_id: current_user.id)
    Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    @user = User.find(params[:user_id])
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @room.entries.each do |entry|
        unless entry.user_id == current_user.id
          @user= User.find(entry.user_id)
        end
      end
      @message = Message.new
    else
      redirect_back(fallback_location: user_path(current_user))
    end
  end

end
