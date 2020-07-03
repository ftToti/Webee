class ScoutsController < ApplicationController
	def index
		if params[:version] == 'user'
			@user = User.find(params[:id])
			@scouts = @user.scouts
		elsif params[:version] == 'request'
			@request = Request.find(params[:id])
			@scouts = @request.scouts
		else
			@scouts = current_user.scouts
		end
	end

	def new
		@user = User.find(params[:user])
		@scout = Scout.new
	end

	def create
		@scout = Scout.new(scout_params)
		if @scout.save!
			redirect_to request_path(@scout.request)
		end
	end

	def destroy
		redirect_back(fallback_location: root_path)
	end

	def propriety
		@scout = Scout.find(params[:id])
		@user = @scout.user
		@request = @scout.request
	end

	def selection
		@scout = Scout.find(params[:id])
		if params[:version] == 'allow'
			# 参加者に登録
			@participant = Participant.new
			@participant.user_id = @scout.user_id
			@participant.request_id = @scout.request_id
			@participant.save!
			# 応募者から削除
			@scout.destroy
			redirect_to user_path(current_user)
		elsif params[:version] == 'deny'
			# 応募者から削除
			@scout.destroy
			redirect_to user_path(current_user)
		end
	end

	private
	def scout_params
		params.require(:scout).permit(:user_id, :request_id)
	end
end
