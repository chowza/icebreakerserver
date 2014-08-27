class Message < ActiveRecord::Base

	belongs_to :profile
	belongs_to :recipient, class_name: "Profile", foreign_key: "recipient_id"	
end
