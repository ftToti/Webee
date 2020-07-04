class EvaluationsController < ApplicationController
	def edit
		@eva = Evaluation.find(params[:id])
	end

	def update
		@eva = Evaluation.find(params[:id])
		@eva.update(evaluation_params)
		redirect_to evaluations_unfinished_path
	end

	private
	def evaluation_params
		params.require(:evaluation).permit(:rate, :comment, :status)
	end
end
