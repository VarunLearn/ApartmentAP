class AddLongitudeToApartment < ActiveRecord::Migration
  def change
    add_column :apartments, :longitude, :float
  end
end
