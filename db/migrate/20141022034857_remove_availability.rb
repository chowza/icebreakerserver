class RemoveAvailability < ActiveRecord::Migration
  def change
  	remove_column :profiles, :remember_availability, :boolean
  	remove_column :profiles, :timezone, :integer
  	remove_column :profiles, :remember_availability, :boolean
  	remove_column :profiles, :today_before_five, :boolean
  	remove_column :profiles, :today_after_five, :boolean
  	remove_column :profiles, :tomorrow_before_five, :boolean
  	remove_column :profiles, :tomorrow_after_five, :boolean
  	remove_column :profiles, :updated_availability, :boolean
  end
end
