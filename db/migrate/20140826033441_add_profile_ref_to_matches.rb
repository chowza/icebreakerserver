class AddProfileRefToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :profile, index: true
  end
end
