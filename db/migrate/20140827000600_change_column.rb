class ChangeColumn < ActiveRecord::Migration
  def change
  	remove_column :profiles, :prefers_male, :boolean
  	add_column :profiles, :preferred_gender, :string
  end
end
