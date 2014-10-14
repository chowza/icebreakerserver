module Paperclip
  class Cropper < Thumbnail
    def transformation_command
      if crop_command
        crop_command + super.sub(/ -crop \S+/, '')
      else
        super
      end
    end
    def crop_command
      target = @attachment.instance
      puts target
      puts "just put target"
      if target.cropping?
        ["-crop", "#{(target.crop_w.to_i).round}x#{(target.crop_h.to_i).round}+#{(target.crop_x.to_i).round}+#{(target.crop_y.to_i).round}"]
      end
    end
  end
end