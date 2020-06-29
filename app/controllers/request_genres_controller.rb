class RequestGenresController < ApplicationController
	before_action :authenticate_admin!
	def index
		@request_genre = RequestGenre.new
		@request_genres = RequestGenre.all
	end

	def create
		@request_genre = RequestGenre.new(request_genre_params)
		@request_genre.save!
		redirect_to request_genres_path
	end

	def destroy
		@request_genre = RequestGenre.find(params[:id])
		@request_genre.destroy!
		redirect_to request_genres_path
	end

	private
	def request_genre_params
		params.require(:request_genre).permit(:category)
	end
end
