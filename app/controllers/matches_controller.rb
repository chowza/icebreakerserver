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
        
        #since you liked, check if you were liked back and send a notification and save that a match was made
        @recipient = Match.where("profile_id = ? and swipee_id = ?",params[:match][:swipee_id],params[:match][:profile_id])[0]
        if !@recipient.nil?
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
              
            # in GCM, use notId to signify different notifications. Notifications with the same notId will replace each other whereas different notIds will create new messages.
            # We use the same notId because if someone gets 10 or 1 notification, they are still going to the same matches page.

            # notification to sender
            if @match.profile.push_type == 'gcm'
              gcm.send([@match.profile.client_identification_sequence],data:{message:"Meet or Chat-for-24 with "+@recipient.profile.first_name+"!",title:"You have a new match",notId:"1",swipee_id:@recipient.profile_id,swipee_name:@recipient.profile.first_name,recipient_facebook_id:@recipient.profile.facebook_id})
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
              gcm.send([@recipient.profile.client_identification_sequence],data:{message:"Meet or Chat-for-24 with "+@match.profile.first_name+"!",title:"You have a new match",notId:"1",swipee_id:@match.profile_id,swipee_name:@match.profile.first_name,recipient_facebook_id:@match.profile.facebook_id})
            elsif @recipient.profile.push_type == 'apns'
              #TODO send apple device
            elsif @recipient.profile.push_type == 'mpns'
              #TODO send window device
            elsif @recipient.profile.push_type == 'adm'
              # send to amazon phone
            else
              #not supported
            end

            date = Time.now
            # save both matched = true and also save recipient facebook ids
            if @match.update({match:true, recipient_facebook_id: @recipient.profile.facebook_id, match_time:date}) && @recipient.update({match:true, recipient_facebook_id: @match.profile.facebook_id,match_time:date})
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

  def update
    @match = Match.where("profile_id = ? and swipee_id = ?",params[:id],params[:match][:swipee_id])[0]

    #update rating
    if @match.update(match_params)

      #get last 5 matches for the swipee and average those ratings
      @swipees_matches = Profile.find(params[:match][:swipee_id]).matches.where("match = ? and answer1_rating NOT NULL LIMIT 5 SORT BY created_at DESC",true)
      @swipee_matches[0].profile.looks_last_5_average_rating = @swipee_matches.pluck(:looks_rating).sum/@swipee_matches.count
      @swipee_matches[0].profile.answer1_last_5_average_rating =  @swipee_matches.pluck(:answer1_rating).sum/@swipee_matches.count
      @swipee_matches[0].profile.answer2_last_5_average_rating =  @swipee_matches.pluck(:answer2_rating).sum/@swipee_matches.count
      @swipee_matches[0].profile.answer3_last_5_average_rating =  @swipee_matches.pluck(:answer3_rating).sum/@swipee_matches.count
      @swipee_matches[0].profile.answer4_last_5_average_rating =  @swipee_matches.pluck(:answer4_rating).sum/@swipee_matches.count
      @swipee_matches[0].profile.answer5_last_5_average_rating =  @swipee_matches.pluck(:answer5_rating).sum/@swipee_matches.count
      if @swipee_matches[0].profile.save
        render json: {post_rating_match_details:@match,ratee_post_rating_profile:swipee_matches[0].profile}
      else
        render "saved rating, failed to update user's last 5 average rating"
      end
    else
      render 'failed to update'
    end
  end

  private

  def match_params
      params.require(:match).permit(:swipee_id, :likes, :match,:swipee_name,:profile_id,:recipient_facebook_id,:match_time,:looks_rating,:answer1_rating,:answer2_rating,:answer3_rating,:answer4_rating,:answer5_rating)
  end

end
