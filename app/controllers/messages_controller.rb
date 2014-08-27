class MessagesController < ApplicationController
	

	def show
		@profile = Profile.find_by_facebook_id(params[:id])
		@messages = Message.where("recipient_id = ? AND profile_id = ?", [@profile['id'],params[:recipient_id]],[@profile['id'],params[:recipient_id]]).order(:created_at)
		render json: @messages
	end
end
