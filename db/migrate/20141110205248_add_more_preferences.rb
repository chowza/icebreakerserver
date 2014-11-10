class AddMorePreferences < ActiveRecord::Migration
  def change
  	add_column :profiles, :height, :float
  	add_column :profiles, :preferred_min_height, :float
  	add_column :profiles, :preferred_max_height, :float
  	add_column :profiles, :preferred_max_feet, :integer
	add_column :profiles, :preferred_max_inches, :integer
	add_column :profiles, :preferred_min_feet, :integer
	add_column :profiles, :preferred_min_inches, :integer
	add_column :profiles, :preferred_intentions, :integer, array: true
	add_column :profiles, :preferred_body_type, :integer, array: true
  end
end
