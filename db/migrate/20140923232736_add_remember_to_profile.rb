class AddRememberToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :remember_availability, :boolean
  end
end
