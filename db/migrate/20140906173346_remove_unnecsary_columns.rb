class RemoveUnnecsaryColumns < ActiveRecord::Migration
  def change
	remove_column :matches, :match_type, :string
	remove_column :matches, :first_message_time, :datetime
	add_column :matches, :match_time, :datetime
  end
end
