class AddPhotoUploaded < ActiveRecord::Migration
  def change
  	add_column :profiles, :photos_uploaded, :boolean
  end
end
