class AddReferencesToMessages < ActiveRecord::Migration
  def change
  	add_reference :messages, :profile, index: true
  	remove_reference :messages, :match, index: true
  	remove_column :matches, :swiper_name, :string
  	add_column :messages, :recipient_id, :integer
  	add_column :messages, :recipient_name, :string
  end
end
