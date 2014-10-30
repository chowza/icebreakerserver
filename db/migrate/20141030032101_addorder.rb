class Addorder < ActiveRecord::Migration
  def change
  	add_column :profiles, :order, :integer, array: true, default: '{0,1,2,3,4}'
  end
end
