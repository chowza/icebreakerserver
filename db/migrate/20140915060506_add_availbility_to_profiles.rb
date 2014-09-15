class AddAvailbilityToProfiles < ActiveRecord::Migration
  def change
  	add_column :profiles, :today_before_five, :boolean
  	add_column :profiles, :today_after_five, :boolean
  	add_column :profiles, :tomorrow_before_five, :boolean
  	add_column :profiles, :tomorrow_after_five, :boolean
  	add_column :profiles, :updated_availability, :datetime
  end
end
