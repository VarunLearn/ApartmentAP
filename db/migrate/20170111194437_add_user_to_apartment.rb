class AddUserToApartment < ActiveRecord::Migration
  def change
    add_reference :apartments, :user, index: true, foreign_key: true
  end
end
