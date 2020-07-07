class RelationshipsController < ApplicationController
	before_action :authenticate_user!
	def create
		@user = User.find(params[:id])
		Relationship.create(follower_id: current_user.id, followed_id: @user.id)
		@user.create_notification_follow!(current_user)
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@user = User.find(params[:id])
		Relationship.find_by(follower_id: current_user.id, followed_id: @user.id).destroy
		redirect_back(fallback_location: root_path)
	end
end
