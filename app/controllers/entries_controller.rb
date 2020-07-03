class EntriesController < ApplicationController
	def index
		if params[:version] == 'user'
			@user = User.find(params[:id])
			@entries = @user.entries
		elsif params[:version] == 'request'
			@request = Request.find(params[:id])
			@entries = @request.entries
		else
			@entries = current_user.entries
		end
	end

	def create
		@entry = Entry.new(entry_params)
		@entry.user_id = current_user.id
		@entry.save
		redirect_to entries_path(id: current_user, version: 'user')
	end

	def destroy
		@entry = current_user.entries.find_by(request_id: params[:id])
		@entry.destroy
		redirect_back(fallback_location: root_path)
	end

	def propriety
		@entry = Entry.find(params[:id])
		@user = @entry.user
		@request = @entry.request
	end

	def selection
		@entry = Entry.find(params[:id])
		if params[:version] == 'allow'
			# 参加者に登録
			@participant = Participant.new
			@participant.user_id = @entry.user_id
			@participant.request_id = @entry.request_id
			@participant.save!
			# 応募者から削除
			@entry.destroy
			redirect_to user_path(current_user)
		elsif params[:version] == 'deny'
			# 応募者から削除
			@entry.destroy
			redirect_to user_path(current_user)
		end
	end

	private
	def entry_params
		params.require(:entry).permit(:message, :request_id)
	end
end
