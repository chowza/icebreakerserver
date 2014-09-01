class AddFirstTimeMessageToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :first_message_time, :datetime
  end
end
