class AddUserToTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :manager, index: true
  end
end
