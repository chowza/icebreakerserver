class AddPictureRemoteUrlToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :picture1_from_url, :string
    add_column :profiles, :picture2_from_url, :string
    add_column :profiles, :picture3_from_url, :string
    add_column :profiles, :picture4_from_url, :string
    add_column :profiles, :picture5_from_url, :string
  end
end
