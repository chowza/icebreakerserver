class Match < ActiveRecord::Base
	belongs_to :profile
	belongs_to :swipee, class_name: "Profile", foreign_key: "swipee_id"
	has_many :messages

	scope :sent, -> {where(profile_id:id)}
	scope :received, -> {where(swipee_id:id)};
end
