class RemoveValidFromValidations < ActiveRecord::Migration
  def change
    remove_column :validations, :valid
    add_column :validations, :validated, :boolean
  end
end
