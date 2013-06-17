class ParticipationsController < ApplicationController
  def new
	redirect_to root_url
  end

  def show
	@participation = Participation.find(params[:id])
  end

end
