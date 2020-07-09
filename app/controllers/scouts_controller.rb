class ScoutsController < ApplicationController
	before_action :authenticate_user!
	def new
		@user = User.find(params[:user])
		@scout = Scout.new
	end

	def create
		scout = Scout.new(scout_params)
		if scout.save!
			# 通知を作成
			scout.create_notification_scout!(current_user)
			redirect_to user_path(scout.user), notice: 'スカウトが完了しました'
		else
			flash[:alert] = 'スカウトに失敗しました'
			render 'new'
		end
	end

	def show
		@scout = Scout.find(params[:id])
		@user = @scout.user
		@request = @scout.request
		# 募集締切までの日付を計算
		d1= Date.new(@request.recruiment_end.year, @request.recruiment_end.month, @request.recruiment_end.day)
		d2 = Date.today
		# 募集締切までの日付
		@sa = (d1 -d2).to_i
	end

	def destroy
		flash[:notice] = 'スカウトを削除しました'
		redirect_back(fallback_location: root_path)
	end

	def selection
		@scout = Scout.find(params[:id])
		if params[:version] == 'allow'
			# 参加者に登録
			@participant = Participant.new
			@participant.user_id = @scout.user_id
			@participant.request_id = @scout.request_id
			if @participant.save!
				# スカウトを削除
				@scout.destroy
				redirect_to request_path(@participant.request), notice: '依頼に参加しました'
			end
		elsif params[:version] == 'deny'
			# スカウトを削除
			@scout.destroy
			redirect_to requests_path(id: current_user.id, version: 'scout'), notice: '参加を拒否しました'
		end
	end

	private
	def scout_params
		params.require(:scout).permit(:user_id, :request_id, :message)
	end
end
