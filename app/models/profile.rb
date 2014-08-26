class Profile < ActiveRecord::Base
	validates :preferred_min_age, :numericality => { :greater_than => 18, :less_than_or_equal_to => :preferred_max_age }
	validates :preferred_max_age, :numericality => { :greater_than => 18, :greater_than_or_equal_to => :preferred_min_age }

	has_many :matches
	has_many :messages, through: :matches
	
	has_attached_file :picture1, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}
	has_attached_file :picture2, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}
	has_attached_file :picture3, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}
	has_attached_file :picture4, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}
	has_attached_file :picture5, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}
	
	#Validate the attached image is image/jpg, image/png, etc
    validates_attachment_content_type :picture1, :content_type => /\Aimage\/.*\Z/
    validates_attachment_content_type :picture2, :content_type => /\Aimage\/.*\Z/
    validates_attachment_content_type :picture3, :content_type => /\Aimage\/.*\Z/
    validates_attachment_content_type :picture4, :content_type => /\Aimage\/.*\Z/
    validates_attachment_content_type :picture5, :content_type => /\Aimage\/.*\Z/
end
