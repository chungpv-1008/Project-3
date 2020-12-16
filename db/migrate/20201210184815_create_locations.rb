class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.references :image, null: false, foreign_key: true
      t.string :coordinate
      t.text :content

      t.timestamps
    end
  end
end
