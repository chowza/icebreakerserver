class Profile < ActiveRecord::Base
	validates :preferred_min_age, :numericality => { :greater_than => 18, :less_than_or_equal_to => :preferred_max_age }
	validates :preferred_max_age, :numericality => { :greater_than => 18, :greater_than_or_equal_to => :preferred_min_age }

	has_many :matches
	has_many :messages, through: :matches
end
