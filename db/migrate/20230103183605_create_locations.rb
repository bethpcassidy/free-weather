class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :zipcode
      t.decimal :longitude, precision: 5, scale: 2
      t.decimal :latitude, precision: 5, scale: 2

      t.timestamps
    end
  end
end
