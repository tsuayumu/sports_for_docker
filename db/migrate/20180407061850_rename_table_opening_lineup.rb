class RenameTableOpeningLineup < ActiveRecord::Migration[4.2]
  def change
  	rename_table :opening_starting_lineups, :lineup_manages
  end
end
