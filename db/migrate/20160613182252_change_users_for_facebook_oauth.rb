class ChangeUsersForFacebookOauth < ActiveRecord::Migration
  def change
    remove_column :users, :username
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
  end
end
