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
		
		if @message.save
			# send message
			@recipient = Profile.find(@message['recipient_id'])
			if @recipient.profile.push_type == 'gcm'
				gcm = GCM.new(ENV['GCM_API_KEY'])
				gcm.send([@recipient.profile.client_identification_sequence],data:{message:"You have a new message!",msgcnt:"1",sender_id:@message.profile_id})
			elsif @recipient_id.profile.push_type == 'apns'
				#TODO initialize Apple
			elsif @recipient_id.profile.push_type == 'mpns'
				#TODO initialize Windows
			elsif @recipient_id.profile.push_type == 'adm'
				#TODO intialize amazon
			end
			render json: @message
		else
			render 'failed to save'
		end

	end

	def message_params
      params.require(:message).permit(:content, :profile_id, :recipient_id,:sender_facebook_id,:sender_name) 
  	end

end
