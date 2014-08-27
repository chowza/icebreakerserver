class AddFaceBookIdToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :facebook_id, :integer, :limit =>8
  	remove_column :messages, :recipient_name, :string
  	add_column :messages, :sender_name, :string
  end
end
