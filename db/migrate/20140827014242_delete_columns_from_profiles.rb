class DeleteColumnsFromProfiles < ActiveRecord::Migration
  def change
  	remove_column :profiles, :male, :boolean
  	remove_column :profiles, :image1, :string
  	remove_column :profiles, :image2, :string
  	remove_column :profiles, :image3, :string
  	remove_column :profiles, :image4, :string
  	remove_column :profiles, :image5, :string
  	remove_column :profiles, :birthday, :date
  	remove_column :profiles, :access_token, :string
  end
end
