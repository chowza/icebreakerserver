class AddRatingValidtoMatches < ActiveRecord::Migration
  def change
  	add_column :matches, :rating_valid, :boolean
  end
end
