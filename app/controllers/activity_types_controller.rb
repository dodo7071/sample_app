class ActivityTypesController < ApplicationController

	before_filter :signed_in_user, only: [:create, :destroy]


end
