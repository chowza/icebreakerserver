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
                gcm.send([@match.profile.client_identification_sequence],data:{message:"Meet or Chat-for-24 with "+@recipient.profile.first_name+"!",title:"You have a new match",notId:"1",swipee_id:@recipient.profile.id,swipee_name:@recipient.profile.first_name,recipient_facebook_id:@recipient.profile.facebook_id})
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
                gcm.send([@match.profile.client_identification_sequence],data:{message:"Meet or Chat-for-24 with "+@match.profile.first_name+"!",title:"You have a new match",notId:"1",swipee_id:@match.profile.id,swipee_name:@match.profile.first_name,recipient_facebook_id:@match.profile.facebook_id})
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

    def update
      @match = Match.where("profile_id = ? and swipee_id = ?",params[:id],params[:match][:swipee_id])[0]
      @recipient = Match.where("profile_id = ? and swipee_id = ?",@match.swipee_id,@match.profile_id)[0]

      if @recipient.match_type.nil?

        if @match.update(match_params)
          if @match.match_type == "waiting_for_other_meet"
            type = "Meet Now"
          elsif @match.match_type == "waiting_for_other_chat"
            type = "Chat-for-24"
          else
            type = "have an in App Call"
          end

          #notify recipient what match_type was chosen by the user
        
          if @recipient.profile.push_type == 'gcm'
            gcm.send([@match.profile.client_identification_sequence],data:{message: @match.profile.first_name + " would like to " + type + "!",title:"Your match has made a selection.",notId:"1",swipee_id:@match.profile.id,match_type:@match.match_type})
          elsif @recipient.profile.push_type == 'apns'
            #TODO send apple device
          elsif @recipient.profile.push_type == 'mpns'
            #TODO send window device
          elsif @recipient.profile.push_type == 'adm'
            # send to amazon phone
          else
            #not supported
          end
          render :text => "Recipient not chosen yet", :content_type => 'text/plain'
        else
          #handle error
        end
      elsif @recipient.match_type == params[:match][:match_type]
        if @match.match_type == "waiting_for_other_meet"
          type = "Meet Now"
          @match.match_type = "agreed_to_meet"
          @match.update({match_type:"agreed_to_meet"}) && @recipient.update({match_type:"agreed_to_meet"})
        elsif @match.match_type == "waiting_for_other_chat"
          type = "Chat-for-24"
          @match.match_type = "agreed_to_chat"
          @match.update({match_type:"agreed_to_chat"}) && @recipient.update({match_type:"agreed_to_chat"})
        else
          type = "have an in App Call"
        end
        #notify recipient what match_type was chosen by the user
      
        if @recipient.profile.push_type == 'gcm'
          gcm.send([@match.profile.client_identification_sequence],
            data:{message: @match.profile.first_name + " has agreed to " + type + "!",
              title:"Your match has made a selection.",
              notId:"1",
              swipee_id:@match.profile.id,
              match_type:@match.match_type})
        elsif @recipient.profile.push_type == 'apns'
          #TODO send apple device
        elsif @recipient.profile.push_type == 'mpns'
          #TODO send window device
        elsif @recipient.profile.push_type == 'adm'
          # send to amazon phone
        else
          #not supported
        end
        render :text => "Same", :content_type => 'text/plain'
      
      elsif @recipient.match_type == "waiting_for_other_chat" && @match.match_type == "waiting_for_other_meet"
        @match.update(match_params)
        render :text => "Different sender to change", :content_type => 'text/plain'
      
      elsif @recipient.match_type == "waiting_for_other_meet" && @match.match_type == "waiting_for_other_chat"
        if @match.update(match_params)
          type = "Chat-for-24"
          #notify recipient what match_type was chosen by the user
          if @recipient.profile.push_type == 'gcm'
            gcm.send([@match.profile.client_identification_sequence],
              data:{message: @match.profile.first_name + " has chosen " + type + "!",
                title:"Your match has made a selection.",
                notId:"1",
                swipee_id:@match.profile.id,
                match_type:@match.match_type})
          elsif @recipient.profile.push_type == 'apns'
            #TODO send apple device
          elsif @recipient.profile.push_type == 'mpns'
            #TODO send window device
          elsif @recipient.profile.push_type == 'adm'
            # send to amazon phone
          else
            #not supported
          end
          render :text => "Different receiver to change", :content_type => 'text/plain'
        else
          #handle error
        end
      else
        # handle more when adding in app call  
      end
    end

  def match_params
      params.require(:match).permit(:swipee_id, :likes, :match,:swipee_name,:profile_id,:recipient_facebook_id,:match_type)
  end

end
