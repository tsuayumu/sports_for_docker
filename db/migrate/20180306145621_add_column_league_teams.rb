class AddColumnLeagueTeams < ActiveRecord::Migration[4.2]
  def change
  	add_column :teams, :league_id, :integer
  end
end
