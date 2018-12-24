class ChangeIntegerLimitInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :google_id, :integer, limit: 16
  end
end
