class ProfilesController < ApplicationController
	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers


	def index
		#GET path to profiles
		@profile = Profile.find_by_facebook_id(params[:facebook_id])
		render json: @profile
	end

	def create
		#POST path to profiles
		@profile = Profile.new(profile_params)
		if @profile.save
			render json: @profile
		else
			render 'failed to save'
		end
	end

	def show
		#GET path to profiles/:id
		@profile = Profile.find_by_facebook_id(params[:id])
		if !@profile.nil?
			render json: @profile
		else
			render :text => '', :content_type => 'text/plain'
		end
	end
	
	def update
		#PUT/PATCH path to profiles/:id
		
		@profile = Profile.find_by_facebook_id(params[:id])
		if @profile.update(profile_params)
			render json: @profile
		else
			render 'failed to update'
		end
	end

	def destroy
		#DELETE path to profiles/:id
	end

	private

	def profile_params
	    params.require(:profile).permit(:facebook_id, :age, :first_name, :latitude, :longitude, :answer1, :answer2, :answer3, :answer4, :answer5, :preferred_min_age,
	   	:preferred_max_age, :prefers_male, :preferred_sound, :preferred_distance, :male, :picture1, :picture2, :picture3, :picture4, :picture5)
	end

end
