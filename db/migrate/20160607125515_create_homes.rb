class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :address_1
      t.string :address_2
      t.string :unit
      t.string :city
      t.string :state
      t.string :zip
      t.string :lat
      t.string :long
    end
  end
end
