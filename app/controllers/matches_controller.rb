class MatchesController < ApplicationController
	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers

  	def show
  		
  	end

end
