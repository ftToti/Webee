class SkillsController < ApplicationController
	before_action :authenticate_admin!
	def index
		@skill = Skill.new
		@skills = Skill.all
	end

	def create
		@skill = Skill.new(skill_params)
		@skill.save!
		redirect_to skills_path
	end

	def destroy
		@skill = Skill.find(params[:id])
		@skill.destroy!
		redirect_to skills_path
	end

	private
	def skill_params
		params.require(:skill).permit(:item)
	end
end
