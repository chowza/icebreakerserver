module Paperclip
  class Cropper < Thumbnail
    def initialize(file, options = {}, attachment = nil)
      super
      @current_geometry.width = target.crop_width
      @current_geometry.height = target.crop_height
    end
    def transformation_command
      target = @attachment.instance
      crop_command = ["-crop", "#{target.crop_w}x#{target.crop_h}+#{target.crop_x}+#{target.crop_y}"]
      crop_command + super
    end
  end
end