class AddTeamToTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :parent_team, index: {to_table :teams}
  end
end
