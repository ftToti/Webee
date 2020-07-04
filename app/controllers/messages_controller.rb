class MessagesController < ApplicationController
	before_action :set_room, only: [:create, :destroy]
	before_action :set_message, only: [:edit, :destroy]

	def create
		if Join.where(user_id: current_user.id, room_id: @room.id)
			@message = Message.create(message_params)
			if @message.save!
				@message = Message.new
				gets_joins_all_messages
			end
			redirect_back(fallback_location: root_path)
		else
			flash[:alert] = 'メッセージの送信に失敗しました'
		end
	end

    def destroy
        if @message.destroy
            gets_entries_all_messages
        end
    end

	private
    def set_room
        @room = Room.find(params[:message][:room_id])
    end

    def set_message
        @message = Message.find(params[:id])
    end

    def gets_joins_all_messages
        @messages = @room.messages.includes(:user).order("created_at asc")
        @joins = @room.joins
    end

    def message_params
        params.require(:message).permit(:user_id, :room_id, :body).merge(user_id: current_user.id)
    end

end
