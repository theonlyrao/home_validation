class CreateHomesPicturesTable < ActiveRecord::Migration
  def change
    create_table :homes_pictures, id: false do |t|
      t.belongs_to :home, index: true, foreign_key: true
      t.belongs_to :picture, index: true, foreign_key: true
    end
  end
end
