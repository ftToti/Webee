class MessagesController < ApplicationController
    before_action :authenticate_user!

	def create
        room = Room.find(params[:message][:room_id])
		if Join.where(user_id: current_user.id, room_id: room.id)
		    message = Message.create(message_params)
            flash[:notice] = 'メッセージを送信しました'
			redirect_back(fallback_location: root_path)
		else
			flash[:alert] = 'メッセージの送信に失敗しました'
		end
	end

    def destroy
        message = Message.find(params[:id])
        if message.destroy
            gets_entries_all_messages
        end
    end

	private
    def message_params
        params.require(:message).permit(:user_id, :room_id, :body).merge(user_id: current_user.id)
    end

end
