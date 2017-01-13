class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.integer :zip
      t.string :state
      t.string :country
      t.string :name
      t.string :phone
      t.time :contact_hrs_from
      t.time :contact_hrs_to

      t.timestamps null: false
    end
  end
end
