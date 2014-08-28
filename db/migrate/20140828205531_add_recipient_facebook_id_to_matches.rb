class AddRecipientFacebookIdToMatches < ActiveRecord::Migration
  def change
  	add_column :matches, :recipient_facebook_id, :integer, :limit =>8
  	remove_column :messages, :facebook_id, :integer, :limit =>8
  	add_column :messages, :sender_facebook_id, :integer, :limit =>8
  end
end
