class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update]
	def index
		if params[:version] == 'entry'
			@request = Request.find(params[:id])
			@users = @request.entry_users
		elsif params[:version] == 'scout'
			@request = Request.find(params[:id])
			@users = @request.scout_users
		elsif params[:version] == 'participant'
			@request = Request.find(params[:id])
			@users = @request.participant_users
		elsif params[:version] == 'evaluation'
			@request = Request.find(params[:id])
			@users = @request.evaluation_users
		else
			@users = User.all
		end
	end

	def show
		@user = User.find(params[:id])
		# チャット機能
		if user_signed_in?
			@current_user_join = Join.where(user_id: current_user.id)
			@user_join = Join.where(user_id: @user.id)
			if @user.id != current_user.id
				@current_user_join.each do |cj|
					@user_join.each do |uj|
						# すでにチャットルームが作成されていたらidを取得
						if cj.room_id == uj.room_id
							@have_room = true
							@room_id = cj.room_id
						end
					end
				end
				# チャットルームがなければ作成する
				if @have_room != true
					@room = Room.new
					@join = Join.new
				end
			end
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			SkillSet.where(possible_id: @user.id).destroy_all
			SkillSet.where(good_id: @user.id).destroy_all
			unless params[:possible].nil?
				params[:possible][:skill_ids].each do |p|
					SkillSet.create!(possible_id: @user.id, skill_id: p)
				end
			end
			unless params[:good].nil?
				params[:good][:skill_ids].each do |g|
					SkillSet.create!(good_id: @user.id, skill_id: g)
				end
			end
			redirect_to user_path(@user), notice: 'プロフィールを編集しました'
		else
			render 'edit'
		end
	end

	def relationships
		@user = User.find(params[:id])
		@follow = @user.following_users
		@followed = @user.followed_users
	end

	def evaluations
		@user = User.find(params[:id])
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :desired_reward, :strong_point, :introduction, :profile_image)
	end
end
