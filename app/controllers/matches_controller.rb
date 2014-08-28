class MatchesController < ApplicationController
    require 'gcm'
    # gcm = ::GCM.new(api_key)
    # gcm.send_notification({registration_ids: ["4sdsx", "8sdsd"], data: {score: "5x1"}})
    
	  before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers


  	def show
  		#GET call to matches/:id - used to show an individual's matches
      @matches = Profile.find_by_facebook_id(params[:id]).matches.where("match = ?",true)
  		render json: @matches
  	end

  	def create
  		#POST call to matches - used to add a new like or dislike
      @match = Match.new(match_params)
      if @match.save
        if params[:match][:likes]
          # TODO
          #since you liked, check if you were liked back and send a notification and save that a match was made
          @recipient = Match.find_by_profile_id(params[:match][:swipee_id])
          if @recipient.nil? && @recipient['likes']
            # 2 likes, send match message
            
            #this set up for testing, TODO set up for non testing
            gcm = ::GCM.new(ENV['GCM_API_KEY'])
            @test = Profile.find_by_facebook_id(10100675664421760) # this used for testing purposes
            gcm.send_notification({registration_ids:[@test['client_identification_sequence']],data:{message:"testing",msgcnt:"1",otherdetail:"hekki"}})

            # save that both matched and also save recipient facebook ids
            if @match.update({match:true, recipient_facebook_id: @recipient.profile.facebook_id }) && @recipient.update({match:true, recipient_facebook_id: @match.profile.facebook_id})
              render :text => '', :content_type => 'text/plain'
            else
              #error saving match??
            end
          else
            #1 like, render nothing
            render :text => '', :content_type => 'text/plain'
          end
        else
          #since you didn't like, continue 
          render :text => '', :content_type => 'text/plain'
        end
      else
        #error saving...investigate what the error is
      end
  	end

  def match_params
      params.require(:match).permit(:swipee_id, :likes, :match,:swipee_name,:profile_id,:recipient_facebook_id)
  end

end
