class CreatePaintings < ActiveRecord::Migration[6.0]
  def change
    create_table :paintings do |t|
      t.string :name
      t.integer :year
      t.string :img_url
      t.integer :artist_id
      t.integer :museum_id
    end
  end
end
