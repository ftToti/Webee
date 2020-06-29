class HomeController < ApplicationController
	before_action :authenticate_admin!, only: [:admins_top]
	def top
	end

	def about
	end

	def admins_top
	end
end
