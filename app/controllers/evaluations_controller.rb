class EvaluationsController < ApplicationController

	before_filter :signed_in_user, only: [:create, :destroy]

	def new
		@evaluation = Evaluation.new
	end

	def create
		@evaluation = Evaluation.new(params[:evaluation])
		@evaluation.user_id = current_user.id 
		if @evaluation.save
			flash[:success] = "Evaluation added!"
			redirect_to proc { facility_url(@evaluation.facility_id) }
		end
	end

	def destroy
	end

end
