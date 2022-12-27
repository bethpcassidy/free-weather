class CreateForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :forecasts do |t|
      t.integer :high
      t.integer :low
      t.integer :average
      t.string :body
      t.string :image
      t.string :zipcode

      t.timestamps
    end
  end
end
