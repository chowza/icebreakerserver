module Paperclip
  class Cropper < Thumbnail
    def initialize(file, options = {}, attachment = nil)
      super
      @current_geometry.width = options.crop_w
      @current_geometry.height = options.crop_h
    end
    def target
      @attachment.instance
    end
    def options
      @options
    end
    def transformation_command
      crop_command = ["-crop","#{options.crop_w}x#{options.crop_h}+#{options.crop_x}+#{options.crop_y}","-resize","305x338"]
      crop_command + super
    end
  end
end