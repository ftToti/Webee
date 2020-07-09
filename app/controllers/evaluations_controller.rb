class EvaluationsController < ApplicationController
	before_action :authenticate_user!
	def edit
		@eva = Evaluation.find(params[:id])
	end

	def update
		@eva = Evaluation.find(params[:id])
		if @eva.update(evaluation_params)
			redirect_to evaluations_unfinished_path, notice: '評価が完了しました'
		else
			render :edit
		end
	end

	private
	def evaluation_params
		params.require(:evaluation).permit(:rate, :comment, :status)
	end
end
