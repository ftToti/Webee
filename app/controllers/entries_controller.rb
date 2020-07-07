class EntriesController < ApplicationController
	before_action :authenticate_user!
	def create
		entry = Entry.new(entry_params)
		entry.user_id = current_user.id
		if entry.save
			entry.create_notification_entry!(current_user)
			redirect_to request_path(entry.request), notice: '応募が完了しました'
		else
			# flash.now[:alert] = '応募に失敗しました'
			# @request = request
			# render 'requests/show'
		end
	end

	def destroy
		entry = current_user.entries.find_by(request_id: params[:id])
		if entry.destroy
			flash[:notice] = '応募を取り消しました'
			redirect_back(fallback_location: root_path)
		end
	end

	def propriety
		@entry = Entry.find(params[:id])
		@user = @entry.user
		@request = @entry.request
		# 募集締切までの日付を計算
		d1= Date.new(@request.recruiment_end.year, @request.recruiment_end.month, @request.recruiment_end.day)
		d2 = Date.today
		# 募集締切までの日付
		@sa = (d1 -d2).to_i
	end

	def selection
		@entry = Entry.find(params[:id])
		if params[:version] == 'allow'
			# 参加者に登録
			@participant = Participant.new
			@participant.user_id = @entry.user_id
			@participant.request_id = @entry.request_id
			if @participant.save!
				# 応募者から削除
				@entry.destroy
				redirect_to request_path(@participant.request), notice: '参加を許可しました'
			end
		elsif params[:version] == 'deny'
			# 応募者から削除
			@entry.destroy
			redirect_to user_path(curent_user), notice: '参加を拒否しました'
		end
	end

	private
	def entry_params
		params.require(:entry).permit(:message, :request_id)
	end
end
