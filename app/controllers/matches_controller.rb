class MatchesController < ApplicationController
    require 'gcm'
    # gcm = ::GCM.new(api_key)
    # gcm.send_notification({registration_ids: ["4sdsx", "8sdsd"], data: {score: "5x1"}})
    
	  before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers


  	def show
  		#GET call to matches/:id - used to show an individual's matches
      gcm = ::GCM.new(ENV['GCM_API_KEY'])
      @test = Profile.find_by_facebook_id(params[:id])
      gcm.send_notification({registration_ids:[@test['client_identification_sequence']],data:{message:"testing",msgcnt:"1",otherdetail:"hekki"}})
  		@matches = Profile.find_by_facebook_id(params[:id]).matches.where("match = ?",true)
  		render json: @matches
  	end

  	def create
  		#POST call to matches - used to add a new like or dislike
      @match = Match.new(match_params)
      if @match.save
        if params[:likes]
          # TODO
          #since you liked, check if you were liked back and send a notification and save that a match was made
        else
          #since you didn't like, continue 
        end
      else
        #error saving...investigate what the error is
      end
  	end

  def match_params
      params.require(:match).permit(:swipee_id, :likes, :match,:swipee_name,:profile_id)
  end

end
