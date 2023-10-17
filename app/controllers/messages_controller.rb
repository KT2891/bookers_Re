class MessagesController < ApplicationController

  def create
    @room = Room.find(params[:room_id])
    message = Message.create(params.require(:message).permit(:message, :user_id, :room_id).merge(room_id: @room.id))
  end

  def destroy
    @room = Room.find(params[:room_id])
    @room.messages.destroy_all
  end

end
