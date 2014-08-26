class AddMatchRefToMessages < ActiveRecord::Migration
  def change
    add_reference :messages, :match, index: true
  end
end
