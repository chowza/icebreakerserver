class AddTimezone < ActiveRecord::Migration
  def change
  	add_column :profiles, :timezone, :integer
  end
end
