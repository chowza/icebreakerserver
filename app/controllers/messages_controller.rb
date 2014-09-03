class MessagesController < ApplicationController
	require 'gcm'
	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers

	def show
		@profile = Profile.find_by_facebook_id(params[:id])
		@messages = Message.where("recipient_id = ? AND profile_id = ? OR recipient_id = ? AND profile_id = ?", @profile['id'],params[:recipient_id],params[:recipient_id],@profile['id']).order(:created_at)
		render json: @messages
	end

	def create
		@message = Message.new(message_params)
		
		@first_message_time = Message.where("recipient_id = ? AND profile_id = ? OR recipient_id = ? AND profile_id = ?", @message.profile_id,@message.recipient_id,@message.recipient_id,@message.profile_id).order(:created_at).limit(1).pluck(:created_at)[0]

		if @first_message_time.nil?
			content = "You have 24 hours to talk to " + @message.profile_id.to_s + ". Have fun!"
			@sender = Match.find_by_profile_id(@message.profile_id)
			@recip = Match.find_by_profile_id(@message.recipient_id)
			@now = Time.now
			@sender.update(first_message_time: @now)
			@recip.update(first_message_time: @now)
			@timeLeft = 24
		else
			@timeLeft = ((@first_message_time+24.hours-Time.now)/3600).round
			if @timeLeft > 5
				content = "You have about " + @timeLeft.to_s + " hours to talk."
			elsif @timeLeft > 1
				content = "You only have " + @timeLeft.to_s + " hours left to talk!"
			else 
				content = "You have less than an hour before you lose the chance to talk to " + @message.sender_name+" forever!"
			end
		end

		if @message.save
			if @timeLeft <=0
			else
				# send message
				@recipient = Profile.find(@message.recipient_id)
				if @recipient.push_type == 'gcm'
					gcm = GCM.new(ENV['GCM_API_KEY'])
					gcm.send([@recipient.client_identification_sequence],
						data:{message:content, 
							notId:@message.profile_id, 
							title:"You have a new message from " + @message.profile.first_name+".", 
							sender_name:@message.sender_name,
							message_content:@message.content,
							sender_facebook_id:@message.sender_facebook_id})
				elsif @recipient.push_type == 'apns'
					#TODO initialize Apple
				elsif @recipient.push_type == 'mpns'
					#TODO initialize Windows
				elsif @recipient.push_type == 'adm'
					#TODO intialize amazon
				end
				render json: @message
			end
		else
			render 'failed to save'
		end
	end

	def message_params
      params.require(:message).permit(:content, :profile_id, :recipient_id,:sender_facebook_id,:sender_name) 
  	end

end
