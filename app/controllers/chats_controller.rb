class ChatsController < ApplicationController

  def create
    if UserRoom.where(user_id: current_user.id, room_id: params[:chat][:room_id]).present?
      # 存在していた場合という意味
      # user_id: current_user.idにならないのでは？
      # メッセージとルームIDがあるかのチェック、これUserRoomじゃないの？？
      @message = Chat.create(params.require(:chat).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
    redirect_to "/chats/#{@message.room_id}"
  end

  def show
    @room = Room.find(params[:id])
    if UserRoom.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = @room.chats
      @message = Chat.new
      @entries = @room.user_rooms
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
