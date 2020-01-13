class CreateRankings < ActiveRecord::Migration[4.2]
  def change
    create_table :rankings do |t|
    	t.integer :rank, null: false
    	t.references :team, index: true, foreign_key: true, null: true
      t.timestamps
    end
  end
end
