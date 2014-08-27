class PrepopulateDb < ActiveRecord::Migration
  def change

  	Profile.create(facebook_id:1,age:22,preferred_min_age:25,preferred_max_age:28)
  	Profile.create(facebook_id:2,age:22,preferred_min_age:25,preferred_max_age:28)
  	Profile.create(facebook_id:3,age:22,preferred_min_age:25,preferred_max_age:28)
  	Profile.create(facebook_id:4,age:22,preferred_min_age:25,preferred_max_age:28)
  	Profile.create(facebook_id:5,age:22,preferred_min_age:25,preferred_max_age:28)
  	Profile.create(facebook_id:6,age:22,preferred_min_age:25,preferred_max_age:28)
  	Profile.create(facebook_id:7,age:22,preferred_min_age:25,preferred_max_age:28)
  	Profile.create(facebook_id:8,age:22,preferred_min_age:25,preferred_max_age:28)
  	Profile.create(facebook_id:9,age:22,preferred_min_age:25,preferred_max_age:28)
  	Profile.create(facebook_id:10,age:22,preferred_min_age:25,preferred_max_age:28)
  	Match.create(profile_id:5, match:true, swipee_id:1)
  	Match.create(profile_id:5, match:true, swipee_id:2)
  	Match.create(profile_id:5, match:false, swipee_id:3)
  	Match.create(profile_id:5, match:true, swipee_id:4)
  	Match.create(profile_id:5, match:false, swipee_id:5)
  	Match.create(profile_id:5, match:true, swipee_id:6)
  	Match.create(profile_id:5, match:false, swipee_id:7)


  end
end
