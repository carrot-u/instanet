class AddUserToTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :manager, index: {to_table :users}
  end
end
