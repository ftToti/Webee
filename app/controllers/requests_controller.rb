class RequestsController < ApplicationController
	def index
		if params[:version] == 'wanted'
			@user = User.find(params[:id])
			@requests = @user.requests
		elsif params[:version] == 'favorite'
			@user = User.find(params[:id])
			@requests = @user.favorite_requests
		else
			@requests = Request.all
		end

		@entry = Entry.new
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
			params[:necessary].split(' ').each do |n|
				SkillSet.create!(necessary_id: @request.id, skill_id: n)
			end
			redirect_to request_path(@request)
		end
	end

	def show
		@request = Request.find(params[:id])
		@skill = @request.necessary
		@entry = Entry.new
		@favorite = Favorite.new
		# 募集締切までの日付を計算
		d1= Date.new(@request.recruiment_end.year, @request.recruiment_end.month, @request.recruiment_end.day)
		d2 = Date.today
		# 募集締切までの日付
		@sa = (d1 -d2).to_i
		# ステータスの表示
		case @request.status
		when 'wanted'
			@status = '募集中'
		when 'progress'
			@status = '進行中'
		when 'completed'
			@status = '達成済み'
		when 'cancel'
			@status = '取り下げ'
		end
	end

	def edit
		@request = Request.find(params[:id])
	end

	def update
		@request = Request.find(params[:id])
		# binding.pry
		if params[:status] == 'wanted'
			@request.wanted!
		elsif params[:status] == 'progress'
			@request.progress!
			Entry.where(request_id: @request.id).destroy_all
			Scout.where(request_id: @request.id).destroy_all
		elsif params[:status] == 'completed'
			@request.completed!
			@request.participants.each do |p|
				Evaluation.create!(user_id: p.user_id, request_id: p.request_id)
				p.destroy
			end
		elsif params[:status] == 'cancel'
			@request.cancel!
			Entry.where(request_id: @request.id).destroy_all
			Scout.where(request_id: @request.id).destroy_all
			Participant.where(request_id: @request.id).destroy_all
		else
			@request.update!(request_params)
			SkillSet.where(necessary_id: @request.id).destroy_all
			params[:necessary][:skill_ids].each do |skill|
				SkillSet.create!(necessary_id: @request.id, skill_id: skill)
			end
		end
		redirect_to request_path(@request)
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
