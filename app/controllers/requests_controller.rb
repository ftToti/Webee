class RequestsController < ApplicationController
	def index
		if params[:version] == 'wanted'
			@user = User.find(params[:id])
			@requests = @user.requests
		else
			@requests = Request.all
		end
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
			params[:necessary].each do |n|
				SkillSet.create!(necessary_id: @request.id, skill_id: n)
			end
			redirect_to request_path(@request)
		end
	end

	def show
		@request = Request.find(params[:id])
		@skill = @request.necessary
		@entry = Entry.new
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
