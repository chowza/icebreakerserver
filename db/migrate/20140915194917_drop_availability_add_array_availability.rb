class DropAvailabilityAddArrayAvailability < ActiveRecord::Migration
  def change
  	remove_column :profiles, :today_before_five, :boolean
  	remove_column :profiles, :today_after_five, :boolean
  	remove_column :profiles, :tomorrow_before_five, :boolean
  	remove_column :profiles, :tomorrow_after_five, :boolean
  	add_column :profiles, :today_before_five, :date
  	add_column :profiles, :today_after_five, :date
  	add_column :profiles, :tomorrow_before_five, :date
  	add_column :profiles, :tomorrow_after_five, :date
  end
end
