class AddPercentMessagedToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :percent_messaged, :float
  end
end
