class AddRatingToMatch < ActiveRecord::Migration
  def change
  	add_column :matches, :looks_rating, :integer
  	add_column :matches, :answer1_rating, :integer
  	add_column :matches, :answer2_rating, :integer
  	add_column :matches, :answer3_rating, :integer
  	add_column :matches, :answer4_rating, :integer
  	add_column :matches, :answer5_rating, :integer
  	add_column :profiles, :looks_last_5_average_rating, :integer
  	add_column :profiles, :answer1_last_5_average_rating, :integer
  	add_column :profiles, :answer2_last_5_average_rating, :integer
  	add_column :profiles, :answer3_last_5_average_rating, :integer
  	add_column :profiles, :answer4_last_5_average_rating, :integer
  	add_column :profiles, :answer5_last_5_average_rating, :integer
  	remove_column :profiles, :coffee, :boolean
  	remove_column :profiles, :lunch, :boolean
	remove_column :profiles, :drinks, :boolean
  	remove_column :profiles, :dinner, :boolean
  end
end
