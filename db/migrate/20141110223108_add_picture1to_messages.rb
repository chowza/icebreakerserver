class AddPicture1toMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :sender_picture1, :integer
  end
end
