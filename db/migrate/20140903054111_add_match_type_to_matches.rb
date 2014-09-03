class AddMatchTypeToMatches < ActiveRecord::Migration
  def change
  	add_column :matches, :match_type, :integer #0 for meet now, 1 for chat for 24, 2 for voip if we get to that point...
  end
end
