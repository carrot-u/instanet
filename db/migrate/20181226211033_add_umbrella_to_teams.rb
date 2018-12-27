class AddUmbrellaToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :umbrella, :boolean
  end
end
