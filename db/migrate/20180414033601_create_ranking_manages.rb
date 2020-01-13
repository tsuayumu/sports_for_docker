class CreateRankingManages < ActiveRecord::Migration[4.2]
  def change
    create_table :ranking_manages do |t|
    	t.references :user, index: true, foreign_key: true, null: true
    	t.string :dopester, nul: true
    	t.references :ranking, index: true, foreign_key: true, null: true
    	t.integer :year, null: false
    	t.references :league, index: true, foreign_key: true, null: true
      t.timestamps
    end
  end
end
