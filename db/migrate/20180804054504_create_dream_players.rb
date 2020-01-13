class CreateDreamPlayers < ActiveRecord::Migration[4.2]
  def change
    create_table :dream_players do |t|
    	t.decimal :average, precision: 4, scale: 3, null: false, default: 0.000
    	t.integer :rbi
    	t.integer :homerun
      t.timestamps
    end
  end
end
