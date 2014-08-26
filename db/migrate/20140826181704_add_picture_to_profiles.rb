class AddPictureToProfiles < ActiveRecord::Migration
  def change
  	add_attachment :profiles, :picture1
  	add_attachment :profiles, :picture2
  	add_attachment :profiles, :picture3
  	add_attachment :profiles, :picture4
  	add_attachment :profiles, :picture5
  end
end
