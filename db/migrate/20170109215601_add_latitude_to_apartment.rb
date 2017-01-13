class AddLatitudeToApartment < ActiveRecord::Migration
  def change
    add_column :apartments, :latitude, :float
  end
end
