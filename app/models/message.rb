class Message < ActiveRecord::Base

	belongs_to :match
	belongs_to :profile
	
end
