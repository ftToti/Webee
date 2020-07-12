class RequestsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :check, :create, :edit, :update]
	def index
		if params[:version] == 'entry'
			@user = User.find(params[:id])
			@requests = @user.entry_requests
		elsif params[:version] == 'scout'
			@user = User.find(params[:id])
			@requests = @user.scout_requests
		elsif params[:version] == 'participant'
			@user = User.find(params[:id])
			@requests = @user.participant_requests
		elsif params[:version] == 'favorite'
			@requests = current_user.favorite_requests
		elsif params[:version] == 'user'
			@requests = @user.request
		elsif params[:version] == 'wanted'
			@requests = Request.where(status: 'wanted')
		elsif params[:version] == 'category'
			@genre = RequestGenre.find(params[:id])
			@requests = @genre.requests
		elsif params[:version] == 'search'
			@requests = Request.where(['title Like ?', "%#{params[:keyword]}%"])
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
		if params[:request][:request_genre_id].blank?
			flash.now[:alert] = '依頼ジャンルを選択してください'
			return render 'new'
		end
		if params[:necessary].nil?
			flash.now[:alert] = '必要なスキルを選択してください'
			return render 'new'
		else
			@skills = Skill.find(params[:necessary][:skill_ids])
		end
	end

	def create
		@request = Request.new(request_params)
		@request.user_id = current_user.id
		if @request.save
			params[:necessary].split(' ').each do |n|
				SkillSet.create!(necessary_id: @request.id, skill_id: n)
			end
			redirect_to request_path(@request), notice: '依頼を投稿しました'
		else
			flash[:alert] = '投稿に失敗しました'
			render :new
		end
	end

	def show
		@request = Request.find(params[:id])
		@skill = @request.necessary
		@scout = current_user.scouts.find_by(request_id: @request.id)
		@entry = Entry.new
		@favorite = Favorite.new
		# 募集締切までの日付を計算
		d1= Date.new(@request.recruiment_end.year, @request.recruiment_end.month, @request.recruiment_end.day)
		d2 = Date.today
		# 募集締切までの日付
		@sa = (d1 -d2).to_i
	end

	def edit
		@request = Request.find(params[:id])
	end

	def update
		@request = Request.find(params[:id])
		# binding.pry
		# ステータスを募集中に戻す
		if params[:status] == 'wanted'
			@request.wanted!
			redirect_to request_path(@request), notice: 'ステータスを更新しました'
		# ステータスを進行中に更新
		elsif params[:status] == 'progress'
			@request.progress!
			Entry.where(request_id: @request.id).destroy_all
			Scout.where(request_id: @request.id).destroy_all
			redirect_to request_path(@request), notice: 'ステータスを更新しました'
		# ステータスを完了に更新
		elsif params[:status] == 'completed'
			@request.completed!
			@request.participants.each do |p|
				Evaluation.create!(user_id: p.user_id, request_id: p.request_id, rate: 0.5)
				p.destroy
			end
			redirect_to request_path(@request), notice: 'ステータスを更新しました'
		# ステータスをキャンセルに更新(依頼を取り下げる)
		elsif params[:status] == 'cancel'
			@request.cancel!
			Entry.where(request_id: @request.id).destroy_all
			Scout.where(request_id: @request.id).destroy_all
			Participant.where(request_id: @request.id).destroy_all
			redirect_to request_path(@request), notice: '依頼を取り下げました'
		else
			@request.update!(request_params)
			SkillSet.where(necessary_id: @request.id).destroy_all
			params[:necessary][:skill_ids].each do |skill|
				SkillSet.create!(necessary_id: @request.id, skill_id: skill)
			end
			redirect_to request_path(@request), notice: '依頼を編集しました'
		end
	end

	private
	def request_params
		params.require(:request).permit(:request_genre_id, :title, :content, :reward, :recruiment_end, :delivery_date, :recruiment_max)
	end
end
