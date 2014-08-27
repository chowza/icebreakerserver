class Match < ActiveRecord::Base
	belongs_to :profile
	belongs_to :swipee, class_name: "Profile", foreign_key: "swipee_id"
end
