class AddGoogleAuthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :google_token, :string
    add_column :users, :google_refresh_token, :string
    add_column :users, :google_id, :integer
    add_column :users, :provider, :string
  end
end
