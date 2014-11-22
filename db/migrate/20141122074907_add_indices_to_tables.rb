class AddIndicesToTables < ActiveRecord::Migration
  def change
  	add_index :profiles, :facebook_id, :name => 'facebook_id_ix'
  	add_index :matches, :swipee_id, :name => 'index_matches_on_swipee_id'
  	add_index :messages, :recipient_id, :name => 'index_messages_on_recipient_id'
  end
end
