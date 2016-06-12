class EditHomeAddressColumns < ActiveRecord::Migration
  def change
    remove_column :homes, :address_1
    remove_column :homes, :address_2
    remove_column :homes, :unit
    remove_column :homes, :city
    remove_column :homes, :state
    remove_column :homes, :zip
    add_column :homes, :address, :string
  end
end
