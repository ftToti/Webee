class RequestsController < ApplicationController
	def index
		@requests = Request.all
	end

	def new
		@request = Request.new
	end

	def check
		@request = Request.new(request_params)
	end

	def create
		@request = Request.new(request_params)
		@request.user_id = current_user.id
		if @request.save!
			# 応募に必要なスキルを作成する
			# SkillSet.create!(necessary: @request.id, skill_id: params[:necessary])
			redirect_to request_path(@request)
		end
	end

	def show
		@request = Request.find(params[:id])
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def confirm
	end

	def complete
	end

	def finish
	end

	private
	def request_params
		params.require(:request).permit(:request_genre_id, :title, :content, :reward, :recruiment_end, :delivery_date, :recruiment_max)
	end
end
