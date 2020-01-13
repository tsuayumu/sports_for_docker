class CreatePlayerRecord2017s < ActiveRecord::Migration[4.2]
  def change
    create_table :player_record2017s do |t|
    	t.references :player, index: true, foreign_key: true
    	t.decimal :average, precision: 4, scale: 3, null: false, default: 0.000
    	t.integer :rbi, null: false, default: ""
    	t.integer :homerun, null: false, default: ""
    	t.integer :match, null: false, default: ""
    	t.integer :win, null: false, default: ""
    	t.integer :defeat, null: false, default: ""
    	t.integer :hold, null: false, default: ""
    	t.integer :save, null: false, default: ""
      t.timestamps
    end
  end
end
