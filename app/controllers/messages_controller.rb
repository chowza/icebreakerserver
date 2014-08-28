class MessagesController < ApplicationController
	require 'gcm'
  	# gcm = ::GCM.new(api_key)
  	# gcm.send_notification({registration_ids: ["4sdsx", "8sdsd"], data: {score: "5x1"}})
	def show
		@profile = Profile.find_by_facebook_id(params[:id])
		@messages = Message.where("recipient_id = ? AND profile_id = ?", [@profile['id'],params[:message][:recipient_id]],[@profile['id'],params[:message][:recipient_id]]).order(:created_at)
		render json: @messages
	end

	def create
		@message = Message.new(message_params)
		
		if @message.save

            gcm = ::GCM.new(ENV['GCM_API_KEY'])
#            @recipient = Profile.find(params[:recipient_id])
			@recipient = Profile.find_by_facebook_id(10100675664421760) # this used for testing purposes
            gcm.send_notification({registration_ids:[@recipient['client_identification_sequence']],data:{message:params[:message][:content],msgcnt:"1",sender_name:params[:message][:sender_name],sender_facebook_id:params[:message][:sender_facebook_id]}})

			render json: @profile
		else
			render 'failed to save'
		end

	end

	def message_params
      params.require(:message).permit(:content, :profile_id, :recipient_id,:sender_facebook_id,:sender_name) 
  	end

end
