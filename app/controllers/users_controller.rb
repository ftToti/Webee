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

	private
	def user_params
		params.require(:user).permit(:name, :desired_reward, :strong_point, :introduction, :profile_image, :status)
	end
end
