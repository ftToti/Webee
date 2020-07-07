class FavoritesController < ApplicationController
	before_action :authenticate_user!
	def create
		Favorite.create(user_id: current_user.id, request_id: params[:id])
		redirect_back(fallback_location: root_path)
	end

	def destroy
		Favorite.find_by(user_id: current_user.id, request_id: params[:id]).destroy
		redirect_back(fallback_location: root_path)
	end
end
