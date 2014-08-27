class MatchesController < ApplicationController
	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers

  	def show
  		#GET call to matches/:id - used to show an individual's matches
  		@matches = Profile.find_by_facebook_id(params[:id]).matches.where("match = ?",true)
  		render json: @matches
  	end

  	def create
  		#POST call to matches - used to add a new like or dislike
  		
  	end

end
