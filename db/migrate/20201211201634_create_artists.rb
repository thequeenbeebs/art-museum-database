class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :birth_year
      t.integer :death_year
      t.string :nationality
      t.string :style
      t.string :img_url
    end
  end
end
