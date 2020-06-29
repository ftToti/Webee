class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			if @user.possible.exists?
				@user.possible.destroy
			end

			# SkillSet.create!(
				# possible_id: current_user.id,
				# skill_id: params[:possible][:skill_ids]
				# )

			# params[:possible][:skill_ids].each do |skill|
				# SkillSet.create!(
					# possible_id: current_user.id,
					# good_id: nil,
					# necessary_id: nil,
					# skill_id: skill
					# )
			# end

		end
		redirect_to user_path(@user)
	end

	def relationships
	end

	def favorites
	end

	private
	def user_params
		params.require(:user).permit(:name, :desired_reward, :strong_point, :introduction, :profile_image, :status)
	end
end
