class MatchesController < ApplicationController
    require 'gcm'
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
          @recipient = Match.where("profile_id = ? and swipee_id = ?",params[:match][:swipee_id],params[:match][:profile_id])
          if @recipient.exists?
            if @recipient['likes']
              # 2 likes, send match messages and then save that match = true

              # initialize...
              if @match.profile.push_type == 'gcm' || @recipient.profile.push_type =='gcm'
                gcm = GCM.new(ENV['GCM_API_KEY'])
              elsif @match.profile.push_type == 'apns' || @recipient.profile.push_type =='apns'
                #TODO initialize Apple
              elsif @match.profile.push_type == 'mpns' || @recipient.profile.push_type =='mpns'
                #TODO initialize Windows
              elsif @match.profile.push_type == 'adm' || @recipient.profile.push_type =='adm'
                #TODO intialize amazon
              end
                
              # notification to sender
              if @match.profile.push_type == 'gcm'
                gcm.send([@match.profile.client_identification_sequence],data:{message:"You have a new match!",msgcnt:"1"})
              elsif @match.profile.push_type == 'apns'
                #TODO send apple device
              elsif @match.profile.push_type == 'mpns'
                #TODO send window device elsif @match.profile.push_type == 'adm'
                # send to amazon phone
              else
                #not supported
              end

              #notification to recipient
              if @recipient.profile.push_type == 'gcm'
                gcm.send([@recipient.profile.client_identification_sequence],data:{message:"You have a new match!",msgcnt:"1"})
              elsif @recipient.profile.push_type == 'apns'
                #TODO send apple device
              elsif @recipient.profile.push_type == 'mpns'
                #TODO send window device
              elsif @recipient.profile.push_type == 'adm'
                # send to amazon phone
              else
                #not supported
              end

              # save both matched = true and also save recipient facebook ids
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
            #recipient has never swiped on you, therefore no need to update that a match has happened
            render :text => '', :content_type => 'text/plain'
          end
        else
          #since you didn't like, therefore no need to update that a match has happened
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
