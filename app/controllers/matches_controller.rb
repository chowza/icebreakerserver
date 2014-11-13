class MatchesController < ApplicationController
  require 'gcm'
  before_filter :cors_preflight_check
	after_filter :cors_set_access_control_headers


	def show
		#GET call to matches/:id - used to show an individual's matches
    @matches = Match.where("match = true and profile_id = ?",params[:id]).joins("inner join profiles on profiles.id = matches.swipee_id").order("matches.match_time desc").select("matches.swipee_name,matches.swipee_id,matches.recipient_facebook_id,matches.match_time,matches.answer1_rating,profiles.order as order")
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
              gcm.send([@match.profile.client_identification_sequence],data:{message:"Chat-for-24 with "+@recipient.profile.first_name+"!",title:"You have a new match",notId:"1",swipee_id:@recipient.profile_id,swipee_name:@recipient.profile.first_name,recipient_facebook_id:@recipient.profile.facebook_id,order:@recipient.profile.order[0]})
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
              gcm.send([@recipient.profile.client_identification_sequence],data:{message:"Chat-for-24 with "+@match.profile.first_name+"!",title:"You have a new match",notId:"1",swipee_id:@match.profile_id,swipee_name:@match.profile.first_name,recipient_facebook_id:@match.profile.facebook_id,order:@match.profile.order[0]})
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
    @rator_rating = Match.where("profile_id = ? AND swipee_id = ?",params[:id],params[:match][:swipee_id])[0]

    #update rating
    if @rator_rating.update(match_params)

      #check if the ratee has rated the rator yet, if so mark both ratings as valid
      @ratee_rating = Match.where("swipee_id = ? AND profile_id = ? AND answer1_rating IS NOT NULL",params[:id],params[:match][:swipee_id])[0]
      if @ratee_rating.nil?
        #since the ratee has not yet rated the rator, we don't treat that rating as valid yet. simply render a json and end this server call
        render json: @rator_rating
      else
        #since the ratee has rated the rator, set the rating_valid flag to true, update the last 5 ratings for both users
        @rator_rating.update({rating_valid:true})
        @ratee_rating.update({rating_valid:true})

        #get last 5 matches for the swipee and average those ratings
        @ratee_ratings = Match.where("swipee_id = ? AND answer1_rating IS NOT NULL AND rating_valid IS TRUE",params[:match][:swipee_id]).limit(5).order(created_at: :desc)
        
        @ratee = Profile.find(params[:match][:swipee_id])
        @ratee.looks_last_5_average_rating = @ratee_ratings.pluck(:looks_rating).sum/@ratee_ratings.count
        @ratee.answer1_last_5_average_rating =  @ratee_ratings.pluck(:answer1_rating).sum/@ratee_ratings.count
        @ratee.answer2_last_5_average_rating =  @ratee_ratings.pluck(:answer2_rating).sum/@ratee_ratings.count
        @ratee.answer3_last_5_average_rating =  @ratee_ratings.pluck(:answer3_rating).sum/@ratee_ratings.count

        #get last 5 matches for the swipor and average those ratings
        @rator_ratings = Match.where("profile_id = ? AND answer1_rating IS NOT NULL AND rating_valid IS TRUE",params[:id]).limit(5).order(created_at: :desc)
        @rator = Profile.find(params[:id])
        @rator.looks_last_5_average_rating = @rator_ratings.pluck(:looks_rating).sum/@rator_ratings.count
        @rator.answer1_last_5_average_rating =  @rator_ratings.pluck(:answer1_rating).sum/@rator_ratings.count
        @rator.answer2_last_5_average_rating =  @rator_ratings.pluck(:answer2_rating).sum/@rator_ratings.count
        @rator.answer3_last_5_average_rating =  @rator_ratings.pluck(:answer3_rating).sum/@rator_ratings.count

        if @ratee.save && @rator.save
          render json: {post_rating_match_details:@rator_rating,ratee_post_rating_profile:@ratee}
        else
          render "saved rating, failed to update user's last 5 average ratings"
        end
      end 
    else
      render 'failed to update'
    end
  end

  private

  def match_params
      params.require(:match).permit(:swipee_id, :likes, :match,:swipee_name,:profile_id,:recipient_facebook_id,:match_time,:looks_rating,:answer1_rating,:answer2_rating,:answer3_rating,:rating_valid)
  end

end
