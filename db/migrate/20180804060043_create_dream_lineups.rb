class CreateDreamLineups < ActiveRecord::Migration[4.2]
  def change
    create_table :dream_lineups do |t|
    	t.references :dream_player, foreign_key: true
    	t.references :dream_lineup_manage, index: true, foreign_key: true
    	t.integer :order, null: false
      t.timestamps
    end
  end
end
