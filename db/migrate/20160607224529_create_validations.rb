class CreateValidations < ActiveRecord::Migration
  def change
    create_table :validations do |t|
      t.references :home, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :valid
    end
  end
end
