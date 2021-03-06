class ProfilesController < ApplicationController
	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers


	def index
		#GET path to profiles - used to show people you haven't swiped on yet

		#get current user for their details
		@user = Profile.find_by_facebook_id(params[:facebook_id])
		#get what you've already swiped on
		@already_swiped = Match.where("profile_id = ?", @user['id']).pluck(:swipee_id)
		unless params[:skip_ids].nil?
			@already_swiped = (@already_swiped + JSON.parse(params[:skip_ids])).uniq
		end

		if @already_swiped.empty?
				@users_close_by = Profile.find_by_sql ["SELECT * FROM profiles p WHERE earth_box(ll_to_earth(?,?),?) @> ll_to_earth(p.latitude,p.longitude) AND p.gender = ? AND p.age BETWEEN ? AND ? AND p.height BETWEEN ? AND ? AND p.answer1 IN (?) AND p.answer2 IN (?) AND p.id != ? AND p.percent_messaged BETWEEN (?-0.1) AND (?+0.1) LIMIT 10",@user['latitude'],@user['longitude'],@user['preferred_distance'],@user['preferred_gender'],@user['preferred_min_age'],@user['preferred_max_age'],@user['preferred_min_height'],@user['preferred_max_height'],@user['preferred_intentions'],@user['preferred_body_type'],@user['id'],@user.percent_messaged,@user.percent_messaged]
		else
				@users_close_by = Profile.find_by_sql ["SELECT * FROM profiles p WHERE earth_box(ll_to_earth(?,?),?) @> ll_to_earth(p.latitude,p.longitude) AND p.gender = ? AND p.age BETWEEN ? AND ? AND p.height BETWEEN ? AND ? AND p.answer1 IN (?) AND p.answer2 IN (?) AND p.id != ? AND p.id NOT IN (?) AND p.percent_messaged BETWEEN (?-0.1) AND (?+0.1) LIMIT 10",@user['latitude'],@user['longitude'],@user['preferred_distance'],@user['preferred_gender'],@user['preferred_min_age'],@user['preferred_max_age'],@user['preferred_min_height'],@user['preferred_max_height'],@user['preferred_intentions'],@user['preferred_body_type'],@user['id'],@already_swiped,@user.percent_messaged,@user.percent_messaged]
		end			

		render json: @users_close_by
	end

	def create

		#POST path to profiles - used to create a new user (TODO write some code to prevent someone creating two profiles on a double click)
		@profile = Profile.new(profile_params)

		if @profile.save
			render json: @profile
		else
			render 'failed to save'
		end
	end

	def show
		#GET path to profiles/:id - used to show details of user
		@profile = Profile.find_by_facebook_id(params[:id])
		if !@profile.nil?
			render json: @profile
		else
			render :text => '', :content_type => 'text/plain'
		end
	end
	
	def update
		#PUT/PATCH path to profiles/:id - used to update details of user

		@profile = Profile.find_by_facebook_id(params[:id])

		# percent messaged can also be updated with a rake task every day...this would make this section faster.

		#update percent messaged
		@matches_made = @profile.matches.where("match=?",true).count
		@matches_messaged = @profile.messages.pluck(:recipient_id).uniq.count
		if @matches_messaged == 0 && @matches_made == 0
			@profile.percent_messaged = 1
		else
			@profile.percent_messaged = @matches_messaged.to_f / @matches_made
		end

		if @profile.update(profile_params)
			render json: @profile
		else
			render 'failed to update'
		end
	end

	def crop
		@profile = Profile.find_by_facebook_id(params[:id])
		if picture1_url?
			@profile.picture1_from_url(params[:profile][:picture1_url],params[:profile][:crop_x],params[:profile][:crop_y],params[:profile][:crop_w],params[:profile][:crop_h])
		end
		if picture2_url?
			@profile.picture2_from_url(params[:profile][:picture2_url],params[:profile][:crop_x],params[:profile][:crop_y],params[:profile][:crop_w],params[:profile][:crop_h])
		end
		if picture3_url?
			@profile.picture3_from_url(params[:profile][:picture3_url],params[:profile][:crop_x],params[:profile][:crop_y],params[:profile][:crop_w],params[:profile][:crop_h])
		end
		if picture4_url?
			@profile.picture4_from_url(params[:profile][:picture4_url],params[:profile][:crop_x],params[:profile][:crop_y],params[:profile][:crop_w],params[:profile][:crop_h])
		end
		if picture5_url?
			@profile.picture5_from_url(params[:profile][:picture5_url],params[:profile][:crop_x],params[:profile][:crop_y],params[:profile][:crop_w],params[:profile][:crop_h])
		end
		if @profile.update(profile_params)
			render json: @profile
		else
			render 'failed to update'
		end
	end

	def individual
		@profile = Profile.find(params[:id])
		render json: @profile
	end

	def destroy
		#DELETE path to profiles/:id - used to delete user
	end

	private

	def profile_params
	    params.require(:profile).permit(:facebook_id, :age, :first_name, :latitude, :longitude, :answer1, :answer2, :feet, :inches,:height, :blurb,:preferred_min_feet,:preferred_min_inches,:preferred_min_height,:preferred_max_feet,:preferred_max_inches,:preferred_max_height, :preferred_min_age,:preferred_max_age, :preferred_gender, :preferred_sound, :preferred_distance, :gender, :picture1, :picture2, :picture3, :picture4, :picture5, :photos_uploaded,:client_identification_sequence,:push_type,:percent_messaged,:crop_w,:crop_x,:crop_h,:crop_y,:looks_last_5_average_rating,:answer1_last_5_average_rating,:answer2_last_5_average_rating,:answer3_last_5_average_rating,order:[],preferred_intentions:[],preferred_body_type:[])
	end

	def picture1_url?
		!params[:profile][:picture1_url].blank?
	end

	def picture2_url?
		!params[:profile][:picture2_url].blank?
	end

	def picture3_url?
		!params[:profile][:picture3_url].blank?
	end

	def picture4_url?
		!params[:profile][:picture4_url].blank?
	end

	def picture5_url?
		!params[:profile][:picture5_url].blank?
	end

end
