# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# first 5 are within 5km,
# next 5 are within 10km
# next 5 are within 15 km
# next 3 are within 20km
# final 2 are > 20km but < 30km

profile_list = [
[100007043895527,18,'Carla',43.65,-79.33,1,5,2,1,3,18,25,true,25000,"male","female"],
[100006624015524,19,'Carol',43.65,-79.34,2,5,2,1,3,18,29,true,25000,"male","female"],
[100005726325532,20,'Barbara',43.65,-79.35,3,5,2,1,3,18,30,true,25000,"male","female"],
[100004476465584,21,'Bob',43.65,-79.36,4,5,2,1,3,18,22,true,25000,"female","male"],
[100008198175505,22,'Dick',43.65,-79.37,1,5,2,1,3,18,32,true,25000,"female","male"],
[100005386785558,23,'Jennifer',43.7,-79.37,2,5,2,1,3,18,33,true,25000,"male","female"],
[100007043925509,24,'Taylor',43.7,-79.4,3,5,2,1,3,18,23,true,25000,"male","female"],
[100004597035587,25,'Dick',43.7,-79.3,4,5,2,1,3,18,55,true,25000,"female","male"],
[100004648305565,26,'Harry',43.7,-79.35,1,5,2,1,3,18,34,true,25000,"female","male"],
[100006691935543,27,'Sharon',43.7,-79.33,2,5,2,1,3,18,23,true,25000,"male","female"],
[100004259055589,28,'Dorothy',43.7,-79.5,3,5,2,1,3,18,33,true,25000,"male","female"],
[100007122285534,29,'Linda',43.7,-79.52,4,5,2,1,3,18,32,true,25000,"male","female"],
[100007912035547,30,'Mike',43.7,-79.53,1,5,2,1,3,18,30,true,25000,"female","male"],
[100007256535543,31,'Joe',43.72,-79.5,2,5,2,1,3,18,31,true,25000,"female","male"],
[100005047995621,32,'Mark',43.73,-79.5,3,5,2,1,3,18,33,true,25000,"female","male"],
[100004838205512,33,'Patricia',43.73,-79.55,4,5,2,1,3,18,22,true,25000,"male","female"],
[100005905248511,34,'Mary',43.73,-79.57,1,5,2,1,3,18,30,true,25000,"male","female"],
[100004806348628,35,'Will',43.73,-79.59,2,5,2,1,3,18,28,true,25000,"female","male"],
[100006294798523,36,'Joe',43.73,-79.62,3,5,2,1,3,18,27,true,25000,"female","male"],
[100005133018592,37,'Sandra',43.73,-79.65,4,5,2,1,3,18,26,true,25000,"male","female"]
]


profile_list.each do | facebook_id,age,first_name,latitude,longitude,answer1, answer2, answer3, answer4, answer5, preferred_min_age, preferred_max_age, preferred_sound, preferred_distance, preferred_gender,gender|
	@profile = Profile.new({facebook_id:facebook_id,
		age:age,
		first_name:first_name,
		latitude:latitude,
		longitude:longitude,
		answer1:answer1,
		answer2:answer2,
		answer3:answer3,
		answer4:answer4,
		answer5:answer5,
		preferred_min_age:preferred_min_age,
		preferred_max_age:preferred_max_age,
		preferred_sound:preferred_sound,
		preferred_distance:preferred_distance,
		preferred_gender:preferred_gender,
		gender:gender
	})
	@profile.picture1 = URI.parse('https://s3.amazonaws.com/ibstaging/app/public/iconlight.jpg')
	@profile.picture2 = URI.parse('https://s3.amazonaws.com/ibstaging/app/public/icondark.jpg')
	@profile.picture3 = URI.parse('https://s3.amazonaws.com/ibstaging/app/public/icondark.jpg')
	@profile.picture4 = URI.parse('https://s3.amazonaws.com/ibstaging/app/public/icondark.jpg')
	@profile.picture5 = URI.parse('https://s3.amazonaws.com/ibstaging/app/public/icondark.jpg')
	@profile.save
end

		