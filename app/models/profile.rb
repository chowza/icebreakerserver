class Profile < ActiveRecord::Base
  validates :preferred_min_age, :numericality => { :greater_than => 18, :less_than_or_equal_to => :preferred_max_age }
	validates :preferred_max_age, :numericality => { :greater_than => 18, :greater_than_or_equal_to => :preferred_min_age }
  validates :facebook_id, uniqueness: true

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
    validates_with AttachmentSizeValidator, :attributes => :picture1, :less_than => 1.megabytes
    validates_with AttachmentSizeValidator, :attributes => :picture2, :less_than => 1.megabytes
    validates_with AttachmentSizeValidator, :attributes => :picture3, :less_than => 1.megabytes
    validates_with AttachmentSizeValidator, :attributes => :picture4, :less_than => 1.megabytes
    validates_with AttachmentSizeValidator, :attributes => :picture5, :less_than => 1.megabytes


    def picture1_from_url(url)
        self.picture1 = URI.parse(url)
    end

  	def picture2_from_url(url)
	      self.picture2 = URI.parse(url)
  	end

  	def picture3_from_url(url)
	      self.picture3 = URI.parse(url)
  	end

  	def picture4_from_url(url)
	      self.picture4 = URI.parse(url)
  	end

  	def picture5_from_url(url)
	      self.picture5 = URI.parse(url)
  	end

end
