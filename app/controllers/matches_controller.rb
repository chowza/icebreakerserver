class MatchesController < ApplicationController
	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers

  	def show
  		#get to matches/:id
  		@matches = Profile.find_by_facebook_id(params[:id]).matches.where("match = ?",true)
  		render json: @matches
  	end

end
