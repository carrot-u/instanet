class AddUserToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :manager, index: {to_table: :users}
  end
end
