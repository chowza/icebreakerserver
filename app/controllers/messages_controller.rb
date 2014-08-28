class MessagesController < ApplicationController
	require 'gcm'
  	# gcm = ::GCM.new(api_key)
  	# gcm.send_notification({registration_ids: ["4sdsx", "8sdsd"], data: {score: "5x1"}})
	def show
		@profile = Profile.find_by_facebook_id(params[:id])
		@messages = Message.where("recipient_id = ? AND profile_id = ?", [@profile['id'],params[:recipient_id]],[@profile['id'],params[:recipient_id]]).order(:created_at)
		render json: @messages
	end
end
