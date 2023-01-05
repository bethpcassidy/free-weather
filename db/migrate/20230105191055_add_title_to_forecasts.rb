class AddTitleToForecasts < ActiveRecord::Migration[7.0]
  def change
    add_column :forecasts, :title, :string
  end
end
