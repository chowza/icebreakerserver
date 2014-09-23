class Addlunchdrinkstoprofile < ActiveRecord::Migration
  def change
  		add_column :profiles, :coffee, :boolean
  		add_column :profiles, :lunch, :boolean
	  	add_column :profiles, :drinks, :boolean
  		add_column :profiles, :dinner, :boolean
  end
end
