class AddPictureFileNameToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :picture_file_name, :string
  end
end
