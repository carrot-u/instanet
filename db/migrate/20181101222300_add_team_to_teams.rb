class AddTeamToTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :parent_team, index: true
  end
end
