class ParticipantsController < ApplicationController
	def index
		if params[:version] == 'user'
			@user = User.find(params[:id])
			@participants = @user.participants
		elsif params[:version] == 'request'
			@request = Request.find(params[:id])
			@participants = @request.participants
		else
			@participants = current_user.participants
		end
	end
end
