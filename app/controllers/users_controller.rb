class UsersController < ApplicationController
	def index
		if params[:version] == 'favorite'
			@request = Request.find(params[:id])
			@users = @request.favorited_users
		else
			@users = User.all
		end
	end

	def show
		@user = User.find(params[:id])

		# チャット機能
		if user_signed_in?
			@currentUserJoin = Join.where(user_id: current_user.id)
			@userJoin = Join.where(user_id: @user.id)
			if @user.id != current_user.id
				@currentUserJoin.each do |cj|
					@userJoin.each do |uj|
						if cj.room_id == uj.room_id
							@haveRoom = true
							@roomId = cj.room_id
						end
					end
				end
				if @haveRoom != true
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
		@user.update(user_params)
		SkillSet.where(possible_id: @user.id).destroy_all
		SkillSet.where(good_id: @user.id).destroy_all
		params[:possible][:skill_ids].each do |p|
			SkillSet.create!(possible_id: @user.id, skill_id: p)
		end
		params[:good][:skill_ids].each do |g|
			SkillSet.create!(good_id: @user.id, skill_id: g)
		end
		redirect_to user_path(@user)
	end

	def relationships
		@user = User.find(params[:id])
		@follow = @user.following_users
		@followed = @user.followed_users
	end

	def favorites
	end

	def evaluations
		@user = User.find(params[:id])
	end

	private
	def user_params
		params.require(:user).permit(:name, :desired_reward, :strong_point, :introduction, :profile_image, :status)
	end
end
