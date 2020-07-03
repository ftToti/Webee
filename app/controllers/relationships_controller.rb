class RelationshipsController < ApplicationController
	def create
		Relationship.create(follower_id: current_user.id, followed_id: params[:id])
		redirect_back(fallback_location: root_path)
	end

	def destroy
		Relationship.find_by(follower_id: current_user.id, followed_id: params[:id]).destroy
		redirect_back(fallback_location: root_path)
	end
end
