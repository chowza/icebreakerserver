class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :swipee_id
      t.boolean :likes
      t.boolean :match
      t.string :swiper_name
      t.string :swipee_name

      t.timestamps
    end
  end
end
