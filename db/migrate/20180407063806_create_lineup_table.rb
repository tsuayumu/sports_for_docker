class CreateLineupTable < ActiveRecord::Migration[4.2]
  def change
    create_table :lineups do |t|
    	t.references :player, foreign_key: true
    	t.references :lineup_manage, index: true, foreign_key: true
    	t.integer :order, null: false
    end
  end
end
