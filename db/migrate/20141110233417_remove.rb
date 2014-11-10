class Remove < ActiveRecord::Migration
  def change
  	remove_column :messages, :sender_picture1, :integer
  end
end
