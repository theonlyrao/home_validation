class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :picture
      t.references :home, index: true, foreign_key: true
      t.string :lat
      t.string :long
    end
  end
end
