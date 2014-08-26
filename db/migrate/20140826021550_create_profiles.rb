class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :facebook_id, :limit => 8
      t.integer :age
      t.string :first_name
      t.float :latitude
      t.float :longitude
      t.integer :answer1
      t.integer :answer2
      t.integer :answer3
      t.integer :answer4
      t.integer :answer5
      t.integer :preferred_min_age
      t.integer :preferred_max_age
      t.boolean :prefers_male
      t.boolean :preferred_sound
      t.integer :preferred_distance
      t.string :image1
      t.string :image2
      t.string :image3
      t.string :image4
      t.string :image5
      t.boolean :male
      t.date :birthday
      t.string :access_token
      t.string :client_identification_sequence
      t.string :push_type

      t.timestamps
    end
  end
end
