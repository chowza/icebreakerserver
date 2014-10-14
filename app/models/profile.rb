class Profile < ActiveRecord::Base
  validates :preferred_min_age, :numericality => { :greater_than_or_equal_to => 18, :less_than_or_equal_to => :preferred_max_age }
	validates :preferred_max_age, :numericality => { :greater_than_or_equal_to => 18, :greater_than_or_equal_to => :preferred_min_age }
  validates :facebook_id, uniqueness: true

	has_many :matches
	has_many :messages

	has_attached_file :picture1, styles: {
		  thumb: 'x100',
    	medium: 'x300',
      crop: {processors: [:cropper]}
	}, url: "pictures/:facebook_id/:style/1:dotextension",
  path: ":rails_root/public/:url"
  
  #convert -crop 40x30+10+10 <==this is WxH+OffsetX+OffsetY

	has_attached_file :picture2, styles: {
		  thumb: 'x100',
    	medium: 'x300'
	}, url: "pictures/:facebook_id/:style/2:dotextension",
  path: ":rails_root/public/:url"
	has_attached_file :picture3, styles: {
		  thumb: 'x100',
    	medium: 'x300'
	}, url: "pictures/:facebook_id/:style/3:dotextension",
  path: ":rails_root/public/:url"
	has_attached_file :picture4, styles: {
		  thumb: 'x100',
    	medium: 'x300'
	}, url: "pictures/:facebook_id/:style/4:dotextension",
  path: ":rails_root/public/:url"
	has_attached_file :picture5, styles: {
		  thumb: 'x100',
    	medium: 'x300'
	}, url: "pictures/:facebook_id/:style/5:dotextension",
  path: ":rails_root/public/:url"
	
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

    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
    after_update :reprocess_picture1, :if => :cropping?
    
    def cropping?
      puts "testing123"
      puts crop_x
      puts "testing234"
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
    end

    # def avatar_geometry(style = :original)
    #   @geometry ||= {}
    #   @geometry[style] ||= Paperclip::Geometry.from_file(picture1.path(style))
    # end
    
    private
    
    def reprocess_picture1
      picture1.reprocess!
    end

end
