class AddMatchTypeToMatches < ActiveRecord::Migration
  def change
  	add_column :matches, :match_type, :string 
  end
end
