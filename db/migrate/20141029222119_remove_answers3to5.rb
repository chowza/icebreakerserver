class RemoveAnswers3to5 < ActiveRecord::Migration
  def change
  	remove_column :profiles, :answer3, :integer
  	remove_column :profiles, :answer4, :integer
  	remove_column :profiles, :answer5, :integer
  	remove_column :matches, :answer4_rating, :integer
  	remove_column :matches, :answer5_rating, :integer
  	remove_column :profiles, :answer4_last_5_average_rating, :integer
  	remove_column :profiles, :answer5_last_5_average_rating, :integer
  	add_column :profiles, :feet, :integer
  	add_column :profiles, :inches, :integer
  	add_column :profiles, :blurb, :string
  end
end
