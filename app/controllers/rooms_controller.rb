class RoomsController < ApplicationController
	before_action :authenticate_user!
	def index
		@rooms = current_user.rooms.includes(:messages).order("messages.created_at desc")
	end

	def create
		@room = Room.create
		@joinCurrentUser = Join.create(user_id: current_user.id, room_id: @room.id)
		@joinUser = Join.create(join_room_params)
		redirect_to room_path(@room)
	end

	def show
		@room = Room.find(params[:id])
		if Join.where(user_id: current_user.id, room_id: @room.id).present?
			@room.messages.where(checked: false).each do |message|
				if message.user != current_user
					message.update_attributes(checked: true)
				end
			end
			@messages = @room.messages.includes(:user).order("created_at desc")
			@message = Message.new
			@joins = @room.joins
		else
			redirect_back(fallback_location: root_path)
		end
	end

	private
	def join_room_params
		params.require(:join).permit(:user_id, :room_id).merge(room_id: @room.id)
	end
end
