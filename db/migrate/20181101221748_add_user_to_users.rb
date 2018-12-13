class AddUserToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :manager, index: true
  end
end
