class Addorder < ActiveRecord::Migration
  def change
  	add_column :profiles, :order, :integer, array: true
  end
end
