class RemoveHomeIdFromPictures < ActiveRecord::Migration
  def change
    remove_column :pictures, :home_id
  end
end
