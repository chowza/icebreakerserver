class Profile < ActiveRecord::Base
  validates :preferred_min_age, :numericality => { :greater_than_or_equal_to => 18, :less_than_or_equal_to => :preferred_max_age }
	validates :preferred_max_age, :numericality => { :greater_than_or_equal_to => 18, :greater_than_or_equal_to => :preferred_min_age }
  validates :facebook_id, uniqueness: true

	has_many :matches
	has_many :messages

	has_attached_file :picture1, styles: lambda {|a| {
		  thumb: 'x100',
    	# medium: 'x300',
      medium: {processors: [:cropper],crop_w:a.instance.crop_w,crop_x:a.instance.crop_x,crop_y:a.instance.crop_y,crop_h:a.instance.crop_h}
    }
	}, url: "pictures/:facebook_id/:style/1:dotextension",
  path: ":rails_root/public/:url"
  
  #convert -crop 40x30+10+10 <==this is WxH+OffsetX+OffsetY

	has_attached_file :picture2, styles: lambda {|a| {
		  thumb: 'x100',
    	# medium: 'x300',
      medium: {processors: [:cropper],crop_w:a.instance.crop_w,crop_x:a.instance.crop_x,crop_y:a.instance.crop_y,crop_h:a.instance.crop_h}
    }
	}, url: "pictures/:facebook_id/:style/2:dotextension",
  path: ":rails_root/public/:url"

	has_attached_file :picture3, styles: lambda {|a| {
		  thumb: 'x100',
    	# medium: 'x300',
      medium: {processors: [:cropper],crop_w:a.instance.crop_w,crop_x:a.instance.crop_x,crop_y:a.instance.crop_y,crop_h:a.instance.crop_h}
    }
	}, url: "pictures/:facebook_id/:style/3:dotextension",
  path: ":rails_root/public/:url"
	has_attached_file :picture4, styles: lambda {|a| {
		  thumb: 'x100',
    	# medium: 'x300',
      medium: {processors: [:cropper],crop_w:a.instance.crop_w,crop_x:a.instance.crop_x,crop_y:a.instance.crop_y,crop_h:a.instance.crop_h}
    }
	}, url: "pictures/:facebook_id/:style/4:dotextension",
  path: ":rails_root/public/:url"
	has_attached_file :picture5, styles: lambda {|a| {
		  thumb: 'x100',
    	# medium: 'x300',
      medium: {processors: [:cropper],crop_w:a.instance.crop_w,crop_x:a.instance.crop_x,crop_y:a.instance.crop_y,crop_h:a.instance.crop_h}
    }
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


    def picture1_from_url(url,crop_w,crop_h,crop_x,crop_y)
        self.crop_w = crop_w
        self.crop_h = crop_h
        self.crop_x = crop_x
        self.crop_y = crop_y
        self.picture1 = URI.parse(url)
    end

  	def picture2_from_url(url,crop_w,crop_h,crop_x,crop_y)
        self.crop_w = crop_w
        self.crop_h = crop_h
        self.crop_x = crop_x
        self.crop_y = crop_y
	      self.picture2 = URI.parse(url)
  	end

  	def picture3_from_url(url,crop_w,crop_h,crop_x,crop_y)
        self.crop_w = crop_w
        self.crop_h = crop_h
        self.crop_x = crop_x
        self.crop_y = crop_y
	      self.picture3 = URI.parse(url)
  	end

  	def picture4_from_url(url,crop_w,crop_h,crop_x,crop_y)
        self.crop_w = crop_w
        self.crop_h = crop_h
        self.crop_x = crop_x
        self.crop_y = crop_y
	      self.picture4 = URI.parse(url)
  	end

  	def picture5_from_url(url,crop_w,crop_h,crop_x,crop_y)
        self.crop_w = crop_w
        self.crop_h = crop_h
        self.crop_x = crop_x
        self.crop_y = crop_y
	      self.picture5 = URI.parse(url)
  	end

    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

end
